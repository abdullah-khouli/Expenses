import 'package:get/get.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;
  changeCurrentIndex(int newIndex) {
    currentIndex.value = newIndex;
  }
}
