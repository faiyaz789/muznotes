import 'package:get/get.dart';

class MyScrollController extends GetxController {
  bool isScroll = false;

  void onToggle() {
    isScroll = !isScroll;
    update();
  }
}
