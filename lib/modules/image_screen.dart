import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:muznotes/controllers/page_controller.dart';
import 'package:muznotes/modules/pdf_screen.dart';
import 'package:muznotes/views/print_widget.dart';
import 'package:screenshot/screenshot.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({Key? key}) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

ScreenshotController screenshotController = ScreenshotController();

class _ImagePageState extends State<ImagePage> {
  final MyPageController myPageController = Get.find();
  int count = 0;
  late Stream<int> generateNumbers;
  @override
  void initState() {
    // TODO: implement initState
    generateNumbers = (() async* {
      //await Future<void>.delayed(Duration(seconds: 2));

      for (int i = 0; i <= myPageController.pages.length; i++) {
        await screenshotController.capture().then((value){print(value);});
        yield i;
      }
    })();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preparing pdf'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PdfScreen()),
              );
            },
            icon: const Icon(Icons.star),
          )
        ],
      ),
      body: //Stack(
          //   children: [
          StreamBuilder<int>(
        stream: generateNumbers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.active
              || snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              if(snapshot.data == 0) {
                return  const Text('start');
              }
              return Screenshot(
                controller: screenshotController,
                child: PrintWidget(
                  painterController:
                  myPageController.painterControllerList[snapshot.data!-1],
                ),
              );
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
          // return Screenshot(
          //   controller: screenshotController,
          //   child: PrintWidget(
          //     painterController:
          //         myPageController.painterControllerList[snapshot.data!],
          //   ),
          // );
        },
      ),

      // Align(
      //   alignment: Alignment.topCenter,
      //   child: Container(
      //     color: Colors.white,
      //     height: MediaQuery.of(context).size.height,
      //   ),
      // )
      // ],
      //),
    );
  }

  void getImage() {
    screenshotController.capture().then((value) {
      print(value);
    });
  }
}
