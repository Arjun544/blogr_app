import 'package:get/get.dart';

import 'articles_screen_controller.dart';

class HomeScreenController extends GetxController {
  final ArticlesScreenController articlesController =
      Get.find<ArticlesScreenController>();

  var currentIndex = 0.obs.toInt();

  void selectedTab(int index) {
    currentIndex = index;
    update();
  }
}
