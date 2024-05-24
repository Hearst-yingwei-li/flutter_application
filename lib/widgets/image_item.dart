import 'package:flutter/material.dart';

class ImageItem extends StatelessWidget {
  const ImageItem(
      {super.key,
      required this.storeName,
      required this.minorversion,
      this.sorPagerange});
  final String? sorPagerange;
  final String storeName;
  final int minorversion;

  @override
  Widget build(BuildContext context) {
    //'https://jd.ao1.hearst.jp:50083/hfgImagePreview/readFile.php?src=ww&jpeg=page${parentModel.sorPagerange}-2&s=${parentModel.pStorename}&mv=${parentModel.pMinorversion}',
    //'https://jd.ao1.hearst.jp:50083/hfgImagePreview/readFile.php?src=ww&jpeg=thumb&s=${child.storename}&mv=${child.minorversion}'
    if (sorPagerange != null) {
      //parent image
      return Image.network(
        'https://jd.ao1.hearst.jp:50083/hfgImagePreview/readFile.php?src=ww&jpeg=page$sorPagerange-2&s=$storeName&mv=$minorversion',
      );
    } else {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Image.network(
            'https://jd.ao1.hearst.jp:50083/hfgImagePreview/readFile.php?src=ww&jpeg=thumb&s=$storeName&mv=$minorversion',
          ),
        ),
      );
    }
  }
}
