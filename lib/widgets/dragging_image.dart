import 'package:flutter/material.dart';

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
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        key: dragKey,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 150,
          width: 150,
          child: Opacity(
              opacity: 0.85,
              child: Image.network(
                'https://jd.ao1.hearst.jp:50083/hfgImagePreview/readFile.php?src=ww&jpeg=thumb&s=$storename&mv=$minorversion',
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }
}
