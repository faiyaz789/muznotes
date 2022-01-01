import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:muznotes/controllers/page_controller.dart';

import 'image_screen.dart';

class PdfScreen extends StatelessWidget {
   PdfScreen({Key? key}) : super(key: key);
  final MyPageController myPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  FutureBuilder<Uint8List?>(
        future: screenshotController.capture(),
        builder:
            (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.data.toString());
            return Image.memory(snapshot.data!);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
