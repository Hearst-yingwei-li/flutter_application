import 'package:flutter/material.dart';
import 'package:flutter_application/provider/main_provider.dart';
import 'package:flutter_application/widgets/image_drop_widget.dart';
import 'package:provider/provider.dart';

class BodyContentImageWidget extends StatelessWidget {
  const BodyContentImageWidget({
    super.key,
    required this.isLeadingImage,
    required this.contentInfo,
  });
  final bool isLeadingImage;
  final Map<String, dynamic> contentInfo;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageDropWidget(
          imgSize: 200,
          isLeadingImage: isLeadingImage,
          contentInfo: contentInfo,
          onDropCallback: (imgUrl) {
            //TODO: remove from List<Map<String,dynamic>>
            //TODO: if is local image, remove data in cloud bucket

            Provider.of<MainProvider>(context, listen: false)
                .updateBodyImageWidget(imgUrl, contentInfo['ukey']);
          },
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            OutlinedButton(
              onPressed: () {
                Provider.of<MainProvider>(context, listen: false)
                    .removeBodyWidget(contentInfo['ukey']);
              },
              child: const Text('Delete'),
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              onPressed: () {
                // Upload from local
                // TODO: upload to storage bucket, get url
                // set url to provider
                // Provider.of<MainProvider>(context, listen: false)
                //     .uploadImageFromLocal();
              },
              child: const Text('Upload'),
            ),
          ],
        )
      ],
    );
  }
}
