
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:muznotes/controllers/erase_controller.dart';
import 'package:muznotes/controllers/page_controller.dart';
import 'package:muznotes/controllers/scroll_controller.dart';

import 'modules/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final controller = Get.put(EraseController());
  final MyPageController pageController = Get.put(MyPageController());
  final MyScrollController myScrollController = Get.put(MyScrollController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

