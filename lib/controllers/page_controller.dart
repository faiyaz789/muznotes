import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muznotes/utils/painter.dart';
import 'package:muznotes/views/NoteWidget.dart';
import 'package:screenshot/screenshot.dart';

class MyPageController extends GetxController {
  PainterController _newController() {
    PainterController controller = PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.transparent;
    return controller;
  }

  Uint8List? uint8list;

  GlobalKey? key1;
  GlobalKey? key2;
  GlobalKey? key3;

  List<PainterController> painterControllerList = <PainterController>[];

  List<Widget> pages = <Widget>[].obs;
  ScreenshotController screenshotController1 = ScreenshotController();

  void addPage() {
    PainterController painterController = _newController();
    pages.add(Builder(builder: (key) {
      return NoteWidget(painterController: painterController);
    }));
    painterControllerList.add(painterController);
  }

  void getImage() {
    //screenshotController1.capture().then((value) => );
  }

  void deletePage(int index) {
    pages.removeAt(index);
    painterControllerList.removeAt(index);
  }

  Future<Uint8List?> capture() {
    return screenshotController1.capture();
    //return Helper.capture(key1!);
  }

  Widget? widget1;
  Widget? widget2;
  Widget? widget3;

  PainterController? painterController1;
  PainterController? painterController2;
  PainterController? painterController3;

  @override
  void onInit() {
    painterController1 = _newController();
    widget1 = NoteWidget(painterController: painterController1!);
    painterControllerList.add(painterController1!);

    painterController2 = _newController();
    widget2 = NoteWidget(painterController: painterController2!);
    painterControllerList.add(painterController2!);

    painterController3 = _newController();
    widget3 = NoteWidget(painterController: painterController3!);
    painterControllerList.add(painterController3!);

    pages.addAll(
      [widget1!, widget2!, widget3!],
    );
    super.onInit();
  }
}
