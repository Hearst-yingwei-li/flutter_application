import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application/provider/main_provider.dart';
import 'package:provider/provider.dart';

class DraggingImage extends StatelessWidget {
  final GlobalKey dragKey;
  final String storename;
  final int minorversion;

  const DraggingImage(
      {super.key,
      required this.dragKey,
      required this.storename,
      required this.minorversion});
  @override
  Widget build(BuildContext context) {
    String imgUrl =
        'https://jd.ao1.hearst.jp:50083/hfgImagePreview/readFile.php?src=ww&jpeg=thumb&s=$storename&mv=$minorversion';
    Uint8List? imageByte =
        Provider.of<MainProvider>(context, listen: false).cacheImages[imgUrl];
    if (imageByte == null) return Container();
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        key: dragKey,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 150,
          width: 150,
          child: Opacity(
            opacity: 0.85, child: Image.memory(imageByte),
            // Image.network(
            //   'https://jd.ao1.hearst.jp:50083/hfgImagePreview/readFile.php?src=ww&jpeg=thumb&s=$storename&mv=$minorversion',
            //   fit: BoxFit.cover,
            // ),
          ),
        ),
      ),
    );
  }
}
