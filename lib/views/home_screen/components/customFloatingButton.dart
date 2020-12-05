import 'package:blogr_app/controllers/add_article_screen_controller.dart';
import 'package:blogr_app/views/add_article_screen/add_article_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFloatingButton extends StatelessWidget {
  CustomFloatingButton({Key key}) : super(key: key);
  final AddArticleController addArticleController =
      Get.find<AddArticleController>();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.transparent,
      elevation: 0,
      onPressed: () {
        addArticleController.titleController.clear();
        Get.to(
          AddArticleScreen(),
        );
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).floatingActionButtonTheme.foregroundColor,
          border: Border.all(
              color:
                  Theme.of(context).floatingActionButtonTheme.backgroundColor,
              width: 6),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
