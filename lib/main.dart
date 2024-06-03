import 'dart:ui';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/consts/enums.dart';
import 'package:flutter_application/provider/main_provider.dart';
import 'package:flutter_application/widgets/custom_dropdown.dart';
import 'package:flutter_application/widgets/edition_container.dart';
import 'package:flutter_application/widgets/magazine_contents.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MainProvider>(
            create: (context) => MainProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse},
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home:
          // const TestImageUpload(),
          // const TestDraggablePageStateless(),
          // const TestImageDownload(),
          HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final GlobalKey _draggableKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 40.0,
          bottom: 20.0,
        ),
        child: Column(children: [
          _dropdownRow(context),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 4,
                  child: MagazineContent(
                    draggableKey: _draggableKey,
                  ),
                ),
                const DottedLine(
                  direction: Axis.vertical,
                ),
                Flexible(
                  flex: 3,
                  child: EditionContainer(),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _dropdownRow(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        const CustomDropdown(
            enumDropdown: EnumDropdown.channelType,
            defaultText: '--publication--'),
        const SizedBox(
          width: 15,
        ),
        const CustomDropdown(
            enumDropdown: EnumDropdown.channel, defaultText: '--channel--'),
        const SizedBox(
          width: 15,
        ),
        const CustomDropdown(
            enumDropdown: EnumDropdown.issue, defaultText: '--issue--'),
        const SizedBox(
          width: 15,
        ),
        const CustomDropdown(
            enumDropdown: EnumDropdown.dossier, defaultText: '--All--'),
        const SizedBox(
          width: 15,
        ),
        Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Consumer<MainProvider>(
              builder: (context, MainProvider model, child) {
            return OutlinedButton(
              onPressed: () {
                debugPrint('submit');
                model.getDossierContent();
              },
              child: const Text('submit'),
            );
          }),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Consumer<MainProvider>(
              builder: (_, MainProvider provider, child) {
            return OutlinedButton(
              onPressed: () async {
                debugPrint('download');
                bool success = await _downloadImages(provider.selectedImages);
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Download Complete!!')));
                  // remove all selected images
                  provider.clearSelectionStatus();
                }
              },
              child: const Text('download'),
            );
          }),
        ),
        const Expanded(child: SizedBox()),
        Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Consumer<MainProvider>(
              builder: (context, MainProvider model, child) {
            return OutlinedButton(
              onPressed: () {
                debugPrint('Confirm');
                model.getDossierContent();
              },
              child: const Text('Confirm'),
            );
          }),
        )
      ],
    );
  }

  Future<bool> _downloadImages(
      Map<int, Map<String, String>> selectedImages) async {
    for (var imageInfo in selectedImages.values) {
      String? imageName = imageInfo['imageName'];
      String? imageUrl = imageInfo['imageUrl'];
      if (imageName == null || imageUrl == null) return false;
      try {
        final response = await http.get(Uri.parse(imageUrl));
        if (response.statusCode == 200) {
          // Convert response body to bytes
          final bytes = response.bodyBytes;
          // Create a blob from the bytes
          final blob = html.Blob([bytes]);
          // Create an object URL for the blob
          final url = html.Url.createObjectUrlFromBlob(blob);
          // Create an anchor element
          html.AnchorElement(href: url)
            ..setAttribute("download", '$imageName.jpg')
            ..click();
          // Revoke the object URL after download
          html.Url.revokeObjectUrl(url);
        } else {
          debugPrint(
              'Failed to download image. Status code: ${response.statusCode}');
          return false;
        }
      } catch (e) {
        debugPrint('Error occurred while downloading image: $e');
        return false;
      }
    }
    return true;
  }
}
