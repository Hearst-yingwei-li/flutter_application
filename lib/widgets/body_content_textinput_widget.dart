import 'package:flutter/material.dart';
import 'package:flutter_application/provider/main_provider.dart';
import 'package:provider/provider.dart';

class BodyContentTextInputWidget extends StatelessWidget {
  const BodyContentTextInputWidget({
    super.key,
    required this.contentInfo,
  });
  final Map<String, dynamic> contentInfo;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextField(
            controller: contentInfo['controller'],
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Text',
            ),
            minLines: 1,
            maxLines: 1000,
            textAlignVertical: TextAlignVertical.top,
          ),
        ),
        IconButton(
          onPressed: () {
            Provider.of<MainProvider>(context, listen: false)
                .removeBodyWidget(contentInfo['ukey']);
          },
          icon: const Icon(Icons.cancel),
        ),
      ],
    );
  }
}
