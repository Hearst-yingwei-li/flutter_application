import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/modules/content_model.dart';
import 'package:flutter_application/provider/main_provider.dart';
import 'package:provider/provider.dart';

class ImageDropWidget extends StatelessWidget {
  const ImageDropWidget({
    super.key,
    required this.isLeadingImage,
    this.onDropCallback,
    this.imgSize,
    this.contentInfo,
  });
  final bool isLeadingImage;
  final void Function(String)? onDropCallback;
  final double? imgSize;
  final Map<String, dynamic>? contentInfo;
  // with param
  // final void Function(bool) onToggle;

  @override
  Widget build(BuildContext context) {
    return DragTarget<ContentModel>(
      builder: (context, candidateItems, rejectedItems) {
        return DottedBorder(
          color: Colors.grey,
          dashPattern: const [6, 3],
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          child: SizedBox(
            height: imgSize ?? 300,
            width: imgSize ?? 300,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Text('Drop area'),
                Consumer<MainProvider>(
                  builder: (context, MainProvider provider, child) {
                    return _getImageWidget(provider);
                  },
                ),
              ],
            ),
          ),
        );
      },
      onAcceptWithDetails: (details) {
        ContentModel contentModel = details.data;
        //
        String imgUrl =
            'https://jd.ao1.hearst.jp:50083/hfgImagePreview/readFile.php?src=ww&jpeg=thumb&s=${contentModel.storename}&mv=${contentModel.minorversion}';
        // debugPrint('set state leading image = ----- $imgUrl');
        if (onDropCallback != null) {
          onDropCallback!(imgUrl);
        }
      },
    );

    ///
    return Consumer<MainProvider>(
        builder: (context, MainProvider provider, child) {
      // return ImageDropWidget(isLeadingImage: true, provider: provider);
      return DragTarget<ContentModel>(
        builder: (context, candidateItems, rejectedItems) {
          return DottedBorder(
            color: Colors.grey,
            dashPattern: const [6, 3],
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            child: SizedBox(
              height: 300,
              width: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Text('Drop area'),
                  Consumer<MainProvider>(
                    builder: (context, MainProvider provider, child) {
                      return _getImageWidget(provider);
                    },
                  ),
                ],
              ),
            ),
          );
        },
        onAcceptWithDetails: (details) {
          ContentModel contentModel = details.data;
          String imgUrl =
              'https://jd.ao1.hearst.jp:50083/hfgImagePreview/readFile.php?src=ww&jpeg=thumb&s=${contentModel.storename}&mv=${contentModel.minorversion}';
          debugPrint('set state leading image = ----- $imgUrl');
          provider.setLeadingImage(imgUrl);
        },
      );
    });
  }

  Widget _getImageWidget(MainProvider provider) {
    // debugPrint('------------- isLeading image = $isLeadingImage');
    if (isLeadingImage) {
      if (provider.imgUrl == null && provider.imgBytes == null) {
        return Container();
      }
      // Leading Image
      if (provider.imgUrl != null) {
        return Image.network(provider.imgUrl!);
      } else {
        return Image.memory(provider.imgBytes!);
      }
    } else {
      // Body Content Image
      if (contentInfo == null ||
          contentInfo!['url'] == null ||
          contentInfo!['url'] == '') {
        return Container();
      }
      if (contentInfo != null) {
        return Image.network(contentInfo!['url']);
      }
    }
    return Container();
  }
}
