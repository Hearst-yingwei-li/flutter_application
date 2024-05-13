import 'package:flutter/material.dart';
import 'package:flutter_application/modules/dossier_model.dart';
import 'package:flutter_application/provider/main_provider.dart';
import 'package:flutter_application/widgets/list_item_story.dart';
import 'package:provider/provider.dart';

class MagazineContent extends StatelessWidget {
  const MagazineContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, MainProvider model, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: model.dossierContentList.length,
            itemBuilder: (context, index) {
              DossierModel dossierModel = model.dossierContentList[index];

              return ListItemStory(
                dossierModel: dossierModel,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
          ),
        );
      },
    );
  }
}
