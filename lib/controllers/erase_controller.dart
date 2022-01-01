import 'package:get/get.dart';

class EraseController extends GetxController{
  var eraseMode = false.obs;

  void onPenMode()
  {
    eraseMode =  RxBool(false);
  }
  void onEraseMode()
  {
    eraseMode =  RxBool(true);
  }
}