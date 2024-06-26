import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/consts/enums.dart';
import 'package:flutter_application/modules/content_model.dart';
import 'package:flutter_application/modules/dossier_model.dart';
import 'package:flutter_application/modules/dossier_response_model.dart';
import 'package:flutter_application/modules/dropdown_model.dart';
import 'package:flutter_application/modules/parent_model.dart';
import 'package:flutter_application/utils/proxy_request.dart';
import 'package:flutter_application/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainProvider extends ChangeNotifier {
  List<DropdownMenuEntry<String>> channelTypes = [
    const DropdownMenuEntry(value: 'print', label: 'print'),
    const DropdownMenuEntry(value: 'web', label: 'web'),
    const DropdownMenuEntry(
        value: 'digital magazine', label: 'digital magazine')
  ];

  List<DropdownMenuEntry<int>> channels = [];
  List<DropdownMenuEntry<int>> issues = [];
  List<DropdownMenuEntry<int>> dossiers = [];

  String? valueChannelType;
  int? valueChannel;
  int? valueIssue;
  int? valueDossier;
  String? imgUrl;
  Uint8List? imgBytes;
  bool isLoading = false;
  List<Map<String, dynamic>> bodyContents = [
    {
      'controller': TextEditingController(),
      'ukey': UniqueKey(),
      'type': EnumWidgetType.textInput
    },
  ];

  List<DossierModel> dossierContentList = [];
  Map<int, Map<String, String>> selectedImages = {};
  Map<String, Uint8List> cacheImages = {};

  void changeDropdownValue(EnumDropdown dropdownType, dynamic value) {
    switch (dropdownType) {
      case EnumDropdown.channelType:
        valueChannelType = value;
        _getChannelData();
        break;
      case EnumDropdown.channel:
        valueChannel = value;
        _getIssueData();
        break;
      case EnumDropdown.issue:
        valueIssue = value;
        _getDossierData();
        break;
      case EnumDropdown.dossier:
        valueDossier = value;
        break;
    }
  }

  void getDossierContent() async {
    if (valueChannelType == null ||
        valueChannel == null ||
        valueIssue == null ||
        valueDossier == null) {
      // TODO:popup window
      return;
    }
    isLoading = true;
    notifyListeners();
    //TODO: Loading
    //{ channelId: channelId, issueId: issueId, dossierId: dossierId }
    var url = 'https://mag2d.hearst.co.jp:5000/get_content_info';
    // var url = 'http://localhost:5000/get_content_info';
    Map<String, dynamic> request = {
      "channelId": valueChannel,
      "issueId": valueIssue,
      "dossierId": valueDossier
    };
    debugPrint(
        "channelId = $valueChannel  issueId = $valueIssue  dossierId = $valueDossier");
    final headers = {'Content-Type': 'application/json'};
    // TODO: Try-Catch block
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(request));
    // debugPrint('response data == ${json.decode(response.body)}');
    DossierResponseModel dossierResponseModel =
        DossierResponseModel.fromJson(json.decode(response.body));
    dossierContentList = List.from(dossierResponseModel.data);
    isLoading = false;
    await requestAllImages(dossierContentList);
    notifyListeners();
  }

  Future<void> requestAllImages(List<DossierModel> dossierContentList) async {
    for (DossierModel dossierModel in dossierContentList) {
      for (ContentModel child in dossierModel.childs) {
        if (child.type == 'Image') {
          ParentModel parentModel = child.parent;
          String parentUrl = Utils.getImageUrl(
              parentModel.pStorename, parentModel.pMinorversion,
              sorPagerange: parentModel.sorPagerange);
          String childUrl =
              Utils.getImageUrl(child.storename, child.minorversion);
          if (!cacheImages.containsKey(parentUrl)) {
            await requestProxyImage(parentUrl);
          }
          if (!cacheImages.containsKey(childUrl)) {
            await requestProxyImage(childUrl);
          }
        }
      }
    }
  }

  Future<void> requestProxyImage(String url) async {
    final response = await fetchDataProxy(url);
    if (response.statusCode == 200) {
      // save to map
      Uint8List imageByte = response.bodyBytes;
      cacheImages[url] = imageByte;
    }
  }

  void setLeadingImage(String? imageUrl) {
    imgBytes = null;
    imgUrl = imageUrl;
    notifyListeners();
  }

  void clearLeadingImage() {
    imgUrl = null;
    imgBytes = null;
    notifyListeners();
  }

  void uploadLeadingImageFromLocal() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      // Specify that you want to pick an image.
      type: FileType.image,
      withData: true,
    );
    if (result != null) {
      imgUrl = null;
      imgBytes = result.files.single.bytes;
      notifyListeners();
    } else {
      debugPrint('No image selected.');
    }
  }

  void _getChannelData() async {
    channels.clear();
    var tempOptions =
        await _getDropdownData('get_channel_list', valueChannelType);
    channels = List.from(tempOptions);
    notifyListeners();
  }

  void _getIssueData() async {
    issues.clear();
    var tempOptions = await _getDropdownData('get_issue_list', valueChannel);
    issues = List.from(tempOptions);
    notifyListeners();
  }

  void _getDossierData() async {
    dossiers.clear();
    // var tempOptions = await _getDropdownData('get_dossier_list', valueIssue,
    //     defaultOption: {'value': -1, 'label': '--All--'});
    var tempOptions = await _getDropdownData('get_dossier_list', valueIssue);
    dossiers = List.from(tempOptions);
    notifyListeners();
  }

  Future<List<DropdownMenuEntry<int>>> _getDropdownData(
      String portName, dynamic dropdownValue,
      {Map<String, dynamic>? defaultOption}) async {
    if (dropdownValue == null) return [];
    var url = 'https://mag2d.hearst.co.jp:5000/$portName';
    // var url = 'http://localhost:5000/$portName';
    Map<String, dynamic> request = {"param": dropdownValue!};
    final headers = {'Content-Type': 'application/json'};
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(request));
    // debugPrint(' === decode response === ${response.body}');
    List<DropdownModel> listOptions = json
        .decode(response.body)
        .map<DropdownModel>((data) => DropdownModel.fromJson(data))
        .toList();

    List<DropdownMenuEntry<int>> temp = [];
    if (defaultOption != null) {
      temp.add(DropdownMenuEntry(
          value: defaultOption['value'], label: defaultOption['label'] ?? ''));
    }
    for (DropdownModel item in listOptions) {
      temp.add(DropdownMenuEntry(value: item.id, label: item.name ?? ''));
    }
    return temp;
  }

  void changeImageSelectionStatus(
      int imageId, String imageName, String imageUrl) {
    // debugPrint(
    //     '------ imageId = $imageId  imageName = $imageName  imageUrl = $imageUrl');

    Map<String, String>? imageInfo = selectedImages[imageId];

    if (imageInfo == null) {
      // check - add new entity - check
      selectedImages[imageId] = {"imageName": imageName, "imageUrl": imageUrl};
    } else {
      // uncheck
      selectedImages.removeWhere((key, value) => key == imageId);
    }
    notifyListeners();
    // debugPrint('selectedImages ----- $selectedImages');
  }

  void clearSelectionStatus() {
    selectedImages.clear();
    notifyListeners();
  }

  void createBodyTextEditWidget() {
    Map<String, dynamic> item = {
      'controller': TextEditingController(),
      'ukey': UniqueKey(),
      'type': EnumWidgetType.textInput
    };
    bodyContents.add(item);
    notifyListeners();
  }

  void removeBodyWidget(Key key) {
    bodyContents.removeWhere((field) => field['ukey'] == key);
    notifyListeners();
  }

  void createBodyImageWidget() {
    Map<String, dynamic> item = {
      'url': '',
      'ukey': UniqueKey(),
      'type': EnumWidgetType.image
    };
    bodyContents.add(item);
    notifyListeners();
  }

  void updateBodyImageWidget(String url, Key key) {
    var contentIndex =
        bodyContents.indexWhere((element) => element['ukey'] == key);
    bodyContents[contentIndex]['url'] = url;
    debugPrint('update body image url === $url \n bodycontent = $bodyContents');
    notifyListeners();
  }
}
