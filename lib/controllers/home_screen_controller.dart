import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  var currentIndex = 0.obs.toInt();

  void selectedTab(int index) {
    currentIndex = index;

    update();
  }
}
