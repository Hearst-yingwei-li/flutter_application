import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/modules/content_model.dart';
import 'package:flutter_application/modules/parent_model.dart';
import 'package:flutter_application/widgets/dragging_image.dart';
import 'package:flutter_application/widgets/image_item.dart';

class StoryLayerImages extends StatelessWidget {
  final List<ContentModel> images;
  final GlobalKey draggableKey;
  const StoryLayerImages(
      {super.key, required this.images, required this.draggableKey});

  @override
  Widget build(BuildContext context) {
    List<List<ContentModel>> listImages = _getImageLayers(images);
    debugPrint('>>>>> story layer images >>> list images = $listImages');
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
          child: ImageItem(
            sorPagerange: parentModel.sorPagerange,
            storeName: parentModel.pStorename,
            minorversion: parentModel.pMinorversion,
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
              ContentModel child = childImageList[index];
              return Draggable<ContentModel>(
                data: child,
                dragAnchorStrategy: pointerDragAnchorStrategy,
                feedback: DraggingImage(
                  dragKey: draggableKey,
                  storename: child.storename,
                  minorversion: child.minorversion,
                  //    'https://jd.ao1.hearst.jp:50083/hfgImagePreview/readFile.php?src=ww&jpeg=thumb&s=${child.storename}&mv=${child.minorversion}',
                ),
                child: ImageItem(
                  storeName: child.storename,
                  minorversion: child.minorversion,
                ),
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
