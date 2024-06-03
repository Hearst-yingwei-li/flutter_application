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
      children: _getColumnChildren(listImages),
    );
  }

  List<Widget> _getColumnChildren(List<List<ContentModel>> listImages) {
    List<Widget> widgets = [];
    for (List<ContentModel> childImageList in listImages) {
      widgets.add(_getImageLayer(childImageList));
    }
    return widgets;
  }

  Widget _getImageLayer(List<ContentModel> childImageList) {
    if (childImageList.isEmpty) return Container();
    ParentModel parentModel = childImageList.first.parent;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Parent Image
        SizedBox(
          height: 500,
          child: Image.network(
            Utils.getImageUrl(parentModel.pStorename, parentModel.pMinorversion,
                sorPagerange: parentModel.sorPagerange),
          ),
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
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Draggable<ContentModel>(
                      data: childModel,
                      dragAnchorStrategy: pointerDragAnchorStrategy,
                      feedback: DraggingImage(
                        dragKey: draggableKey,
                        storename: childModel.storename,
                        minorversion: childModel.minorversion,
                      ),
                      child: Image.network(
                        imageUrl,
                      ),
                    ),
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
                                  childModel.id, childModel.name, imageUrl);
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
