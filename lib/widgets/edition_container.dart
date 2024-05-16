import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/modules/content_model.dart';
import 'package:flutter_application/provider/main_provider.dart';
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
                _imageDropArea(),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _btnDelete(),
                    const SizedBox(
                      height: 10,
                    ),
                    _btnUploadFromLocal()
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
            // Image
            _bodyTextInput(),
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

  Widget _imageDropArea() {
    return Consumer<MainProvider>(
        builder: (context, MainProvider provider, child) {
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
                      return _getLeadingImage(provider);
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

  Widget _getLeadingImage(MainProvider provider) {
    if (provider.imgUrl == null && provider.imgBytes == null) {
      return Container();
    } else if (provider.imgUrl != null) {
      return Image.network(provider.imgUrl!);
    } else {
      return Image.memory(provider.imgBytes!);
    }
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

  Widget _btnDelete() {
    return Consumer<MainProvider>(
        builder: (context, MainProvider provider, child) {
      return OutlinedButton(
        onPressed: () {
          provider.clearLeadingImage();
        },
        child: const Text('Clear'),
      );
    });
  }

  Widget _btnUploadFromLocal() {
    return Consumer<MainProvider>(
        builder: (context, MainProvider provider, child) {
      return OutlinedButton(
        onPressed: () {
          // TODO:
          provider.uploadImageFromLocal();
        },
        child: const Text('Upload'),
      );
    });
  }
}
