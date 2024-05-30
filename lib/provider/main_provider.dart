import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/consts/enums.dart';
import 'package:flutter_application/modules/article_xml_model.dart';
import 'package:flutter_application/modules/content_model.dart';
import 'package:flutter_application/modules/dossier_model.dart';
import 'package:flutter_application/modules/dossier_response_model.dart';
import 'package:flutter_application/modules/dropdown_model.dart';
import 'package:flutter_application/modules/response_article_xml_model.dart';
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

  List<DossierModel> dossierContentList = [];

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
    var url = 'http://localhost:5000/get_content_info';

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
    debugPrint('response data == ${json.decode(response.body)}');
    DossierResponseModel dossierResponseModel =
        DossierResponseModel.fromJson(json.decode(response.body));
    dossierContentList = List.from(dossierResponseModel.data);
    isLoading = false;
    notifyListeners();
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

  void uploadImageFromLocal() async {
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
    var tempOptions = await _getDropdownData('get_dossier_list', valueIssue,
        defaultOption: {'value': -1, 'label': '--All--'});
    dossiers = List.from(tempOptions);
    notifyListeners();
  }

  Future<List<DropdownMenuEntry<int>>> _getDropdownData(
      String portName, dynamic dropdownValue,
      {Map<String, dynamic>? defaultOption}) async {
    if (dropdownValue == null) return [];
    var url = 'http://localhost:5000/$portName';

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

  // String _getDropdownTitle(EnumDropdown enumDropdown, int? value) {
  //   if (value == null) return '';
  //   List<DropdownMenuEntry<int>>? entries;
  //   switch (enumDropdown) {
  //     case EnumDropdown.channel:
  //       entries = channels;
  //       break;
  //     case EnumDropdown.issue:
  //       entries = issues;
  //       break;
  //     case EnumDropdown.dossier:
  //       entries = dossiers;
  //       break;
  //     default:
  //       break;
  //   }
  //   if (entries == null) return '';
  //   for (DropdownMenuEntry<int> entryValue in entries) {
  //     if (entryValue.value == value) {
  //       return entryValue.label;
  //     }
  //   }
  //   return '';
  // }
}
