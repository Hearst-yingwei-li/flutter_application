import 'package:flutter/material.dart';
import 'package:flutter_application/modules/article_xml_model.dart';
import 'package:flutter_application/modules/content_model.dart';
import 'package:flutter_application/modules/dossier_model.dart';
import 'package:flutter_application/widgets/story_layer_images.dart';

class ListItemStory extends StatelessWidget {
  final DossierModel dossierModel;
  final GlobalKey draggableKey;
  const ListItemStory({
    super.key,
    required this.dossierModel,
    required this.draggableKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${dossierModel.name} page: ${dossierModel.pagerange}',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.yellowAccent.withOpacity(0.3),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        _createStoryWidget(dossierModel),
      ],
    );
  }

  Widget _createStoryWidget(DossierModel dossierModel) {
    // debugPrint('>>>>>>>>>>>>>> storename == ${dossierModel.name}');
    List<ContentModel> images = [];
    List<String>? articlePlaintexts;
    for (var child in dossierModel.childs) {
      if (child.type == 'Article') {
        articlePlaintexts = List.from(child.articlePlaintexts ?? []);
      } else if (child.type == 'Image') {
        images.add(child);
      }
    }
    // debugPrint('>>>>> create story widget ----> images = ${images.length}');
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '=== Possible Titles ===',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        ..._getArticleXMLText(dossierModel.childs, true),
        const SizedBox(
          height: 10,
        ),
        const Text(
          '=== Possible Leads ===',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        ..._getArticleXMLText(dossierModel.childs, false),
        const SizedBox(
          height: 10,
        ),
        const Text(
          '=== Images ===',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        StoryLayerImages(
          images: images,
          draggableKey: draggableKey,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          '=== Articles ===',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        ..._getArticlePlaintexts(articlePlaintexts),
      ],
    );
  }

  List<SelectableText> _getArticlePlaintexts(List<String>? articlePlaintexts) {
    if (articlePlaintexts == null) return [];
    List<SelectableText> listPlaintexts = [];
    for (var child in articlePlaintexts) {
      SelectableText text = SelectableText(child);
      listPlaintexts.add(text);
    }
    return listPlaintexts;
  }

  List<SelectableText> _getArticleXMLText(
      List<ContentModel> listContent, bool isTitle) {
    List<SelectableText> listResult = [];
    List<ArticleXMLModel> listTarget = [];
    for (var content in listContent) {
      List<ArticleXMLModel>? headlines = content.headlines;
      if (headlines == null) continue;
      int sepIndex = _getHeadlinesAndLeadingsIndex(headlines);
      if (isTitle) {
        listTarget.addAll(headlines.sublist(0, sepIndex));
      } else {
        listTarget.addAll(headlines.sublist(sepIndex));
      }
    }
    for (ArticleXMLModel content in listTarget) {
      SelectableText text = SelectableText('・${content.snipText}');
      listResult.add(text);
    }
    // debugPrint('headlines ------------ $listResult');
    return listResult;
  }

  int _getHeadlinesAndLeadingsIndex(List<ArticleXMLModel> articleXMLModels) {
    int titleMaxCount = 3;
    double? minSize;
    int titleCount = 0;
    for (var i = 0; i < articleXMLModels.length; i++) {
      ArticleXMLModel item = articleXMLModels[i];
      if (minSize == null ||
          (titleCount < titleMaxCount && item.fontSize < minSize)) {
        titleCount++;
        minSize = item.fontSize;
      } else {
        return i;
      }
    }
    return 0;
  }
}
