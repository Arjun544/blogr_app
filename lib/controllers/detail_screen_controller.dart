import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class DetailScreenController extends GetxController {
  final ScrollController controller = ScrollController();
  ValueNotifier<bool> visible = ValueNotifier<bool>(true);

  hideArticleOptions() {
    visible.value = true;
    controller.addListener(
      () {
        if (controller.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (visible.value) {
            visible.value = false;
            update();
          }
        }

        if (controller.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!visible.value) {
            visible.value = true;
            update();
          }
        }
      },
    );
  }
}
