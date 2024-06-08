import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/modules/content_model.dart';
import 'package:flutter_application/provider/main_provider.dart';
import 'package:flutter_application/widgets/body_content_image_widget.dart';
import 'package:flutter_application/widgets/body_content_list_widget.dart';
import 'package:flutter_application/widgets/body_content_textinput_widget.dart';
import 'package:flutter_application/widgets/image_drop_widget.dart';
import 'package:provider/provider.dart';

class EditionContainer extends StatelessWidget {
  EditionContainer({super.key});
  final TextEditingController _bodyInputController = TextEditingController();
  final TextEditingController _articleHeadlineInputController =
      TextEditingController();
  final TextEditingController _articleLeadInputController =
      TextEditingController();
  //
  final TextEditingController _homepageHeadlineInputController =
      TextEditingController();
  final TextEditingController _socialHeadlineInputController =
      TextEditingController();
  final TextEditingController _metaTitleInputController =
      TextEditingController();
  final TextEditingController _descriptionInputController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // return _imageDropZone();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleWidget('Article Headline & Dek'),
            _articleHeadlineContainer(),
            const SizedBox(
              height: 15,
            ),
            _titleWidget('Social/Homepage Headlines & Dek'),
            _socialHomepageHeadlineContainer(),
            const SizedBox(
              height: 15,
            ),
            _titleWidget('Meta Title & Description'),
            _metaDescriptionContainer(),
            const SizedBox(
              height: 15,
            ),
            _titleWidget('Lead Image'),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageDropWidget(
                  isLeadingImage: true,
                  onDropCallback: (imgUrl) {
                    Provider.of<MainProvider>(context, listen: false)
                        .setLeadingImage(imgUrl);
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _btnDelete(context),
                    const SizedBox(
                      height: 10,
                    ),
                    _btnUploadFromLocal(context),
                  ],
                )
              ],
            ),
            // _imageDropZone(),
            // _testDropText(),
            const SizedBox(
              height: 15,
            ),
            _titleWidget('Body'),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    // Add text edit
                    Provider.of<MainProvider>(context, listen: false)
                        .createBodyTextEditWidget();
                  },
                  icon: const Icon(Icons.text_fields),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    // Add drop image
                    Provider.of<MainProvider>(context, listen: false)
                        .createBodyImageWidget();
                  },
                  icon: const Icon(Icons.image),
                ),
              ],
            ),
            const BodyContentListWidget(),
          ],
        ),
      ),
    );
  }

  Widget _titleWidget(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  Widget _articleHeadlineContainer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _articleHeadlineInputController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Head',
          ),
          // minLines: 1,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.top,
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _articleLeadInputController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Lead',
          ),
          // minLines: 1,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.top,
        ),
      ],
    );
  }

  Widget _socialHomepageHeadlineContainer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _homepageHeadlineInputController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Top5 Frame Headline',
          ),
          // minLines: 1,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.top,
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _socialHeadlineInputController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Headline for Social Media',
          ),
          // minLines: 1,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.top,
        ),
      ],
    );
  }

  Widget _metaDescriptionContainer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _metaTitleInputController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Meta Title',
          ),
          // minLines: 1,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.top,
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _descriptionInputController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Description',
          ),
          // minLines: 1,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.top,
        ),
      ],
    );
  }

  Widget _bodyTextInput() {
    return TextField(
      controller: _bodyInputController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Test',
      ),
      minLines: 10,
      maxLines: 1000,
      textAlignVertical: TextAlignVertical.top,
    );
  }

  Widget _btnDelete(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Provider.of<MainProvider>(context, listen: false).clearLeadingImage();
      },
      child: const Text('Clear'),
    );
  }

  Widget _btnUploadFromLocal(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Provider.of<MainProvider>(context, listen: false)
            .uploadLeadingImageFromLocal();
      },
      child: const Text('Upload'),
    );
  }
}
