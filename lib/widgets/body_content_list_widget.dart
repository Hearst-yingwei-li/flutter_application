import 'package:flutter/material.dart';
import 'package:flutter_application/consts/enums.dart';
import 'package:flutter_application/provider/main_provider.dart';
import 'package:flutter_application/widgets/body_content_image_widget.dart';
import 'package:flutter_application/widgets/body_content_textinput_widget.dart';
import 'package:provider/provider.dart';

class BodyContentListWidget extends StatelessWidget {
  const BodyContentListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        List<Map<String, dynamic>> bodyContents = provider.bodyContents;
        return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> contentInfo = bodyContents[index];
              EnumWidgetType widgetType = contentInfo['type'];
              if (widgetType == EnumWidgetType.image) {
                return BodyContentImageWidget(
                  isLeadingImage: false,
                  contentInfo: contentInfo,
                );
              } else {
                return BodyContentTextInputWidget(contentInfo: contentInfo);
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 10,
              );
            },
            itemCount: bodyContents.length);
      },
    );
  }
}
