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
        ..._getArticleXMLText(dossierModel.titles),
        const SizedBox(
          height: 10,
        ),
        const Text(
          '=== Possible Leads ===',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        ..._getArticleXMLText(dossierModel.leadings),
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
      List<ArticleXMLModel>? titleXMLModels) {
    if (titleXMLModels == null || titleXMLModels.isEmpty) return [];
    List<SelectableText> listTitles = [];
    for (var child in titleXMLModels) {
      SelectableText text = SelectableText('・${child.snipText}');
      listTitles.add(text);
    }
    return listTitles;
  }
}
