import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application/modules/content_model.dart';
import 'package:flutter_application/modules/parent_model.dart';
import 'package:flutter_application/provider/main_provider.dart';
import 'package:flutter_application/utils/utils.dart';
import 'package:flutter_application/widgets/dragging_image.dart';
import 'package:provider/provider.dart';

class StoryLayerImages extends StatelessWidget {
  final List<ContentModel> images;
  final GlobalKey draggableKey;
  const StoryLayerImages(
      {super.key, required this.images, required this.draggableKey});

  @override
  Widget build(BuildContext context) {
    List<List<ContentModel>> listImages = _getImageLayers(images);
    // debugPrint('>>>>> story layer images >>> list images = $listImages');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _getColumnChildren(listImages, context),
    );
  }

  List<Widget> _getColumnChildren(
      List<List<ContentModel>> listImages, BuildContext context) {
    List<Widget> widgets = [];
    for (List<ContentModel> childImageList in listImages) {
      widgets.add(_getImageLayer(childImageList, context));
    }
    return widgets;
  }

  Widget _getImageLayer(
      List<ContentModel> childImageList, BuildContext context) {
    if (childImageList.isEmpty) return Container();
    ParentModel parentModel = childImageList.first.parent;
    String imageParentUrl = Utils.getImageUrl(
        parentModel.pStorename, parentModel.pMinorversion,
        sorPagerange: parentModel.sorPagerange);
    Uint8List? parentImageByte =
        Provider.of<MainProvider>(context, listen: false)
            .cacheImages[imageParentUrl];
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Parent Image
        SizedBox(
          height: 500,
          child: parentImageByte != null
              ? Image.memory(parentImageByte)
              // Image.network(
              //     Utils.getImageUrl(
              //         parentModel.pStorename, parentModel.pMinorversion,
              //         sorPagerange: parentModel.sorPagerange),
              //   )
              : Container(),
        ),
        const SizedBox(
          height: 10,
        ),
        // horizontal listview - child images
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            controller: ScrollController(),
            itemBuilder: (context, index) {
              ContentModel childModel = childImageList[index];
              String imageUrl = Utils.getImageUrl(
                  childModel.storename, childModel.minorversion);
              Uint8List? imageByte =
                  Provider.of<MainProvider>(context, listen: false)
                      .cacheImages[imageUrl];
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: imageByte != null
                        ? Draggable<ContentModel>(
                            data: childModel,
                            dragAnchorStrategy: pointerDragAnchorStrategy,
                            feedback: DraggingImage(
                              dragKey: draggableKey,
                              storename: childModel.storename,
                              minorversion: childModel.minorversion,
                            ),
                            child: Image.memory(imageByte),
                            // Image.network(
                            //   imageUrl,
                            // ),
                          )
                        : Container(),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Consumer<MainProvider>(
                        builder: (BuildContext context, MainProvider provider,
                            Widget? child) {
                          return Checkbox(
                            value: provider.selectedImages
                                .containsKey(childModel.id),
                            onChanged: (value) {
                              provider.changeImageSelectionStatus(
                                  childModel.id,
                                  childModel.name,
                                  Utils.getImageDownloadUrl(
                                      childModel.storename,
                                      childModel.minorversion,
                                      childModel.name));
                            },
                          );
                        },
                      ),
                      Text(childModel.name)
                    ],
                  )
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 10,
              );
            },
            itemCount: childImageList.length,
          ),
        ),
      ],
    );
  }

  List<List<ContentModel>> _getImageLayers(List<ContentModel> images) {
    List<List<ContentModel>> listImages = [];
    List<ContentModel> stack = [];
    for (ContentModel image in images) {
      if (stack.isEmpty) {
        stack.add(image);
        continue;
      }
      if (image.parent == stack.last.parent) {
        stack.add(image);
      } else {
        // pop all element to list
        listImages.add(List.from(stack));
        stack.clear();
        stack.add(image);
      }
    }
    listImages.add(List.from(stack));
    return listImages;
  }
}
