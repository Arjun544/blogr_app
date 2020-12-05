import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/controllers/add_article_screen_controller.dart';
import 'package:blogr_app/controllers/database_controller/database_controller.dart';
import 'package:blogr_app/views/add_article_screen/components/selectCategory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zefyr/zefyr.dart';

import 'components/editor_image.dart';
import 'components/editor_toolbar.dart';

class AddArticleScreen extends StatelessWidget {
  final AddArticleController addArticleController =
      Get.find<AddArticleController>();

  final DatabaseController databaseController = Get.find<DatabaseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).appBarTheme.iconTheme.color,
        ),
        elevation: 0,
        title: Text(
          'Add article',
          style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).textTheme.headline1.color,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              if (addArticleController.titleController.text.length == 0 &&
                  addArticleController.zefyrController.document.length == 0) {
                Get.snackbar(
                  'Empty article',
                  'Please give title and description',
                  colorText: Colors.black,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: EdgeInsets.only(bottom: 50),
                  leftBarIndicatorColor: CustomColors.blackColor,
                  snackStyle: SnackStyle.FLOATING,
                  backgroundColor: Colors.grey.withOpacity(0.5),
                );
              } else {
                Get.to(SelectCategory());
              }
            },
            child: Text(
              'Next',
              style: TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ZefyrScaffold(
          child: ZefyrTheme(
            data: ZefyrThemeData(
              defaultLineTheme: LineTheme(
                textStyle: TextStyle(
                  color: Theme.of(context).textTheme.headline1.color,
                  fontSize: 20,
                ),
                padding: EdgeInsets.only(left: 3),
              ),
              attributeTheme: AttributeTheme.fallback(
                context,
                LineTheme(
                  textStyle: TextStyle(
                    color: Theme.of(context).textTheme.headline1.color,
                    fontSize: 20,
                  ),
                  padding: EdgeInsets.only(left: 3),
                ),
              ),
              toolbarTheme: ToolbarTheme.fallback(context).copyWith(
                color: CustomColors.blackColor,
                toggleColor: CustomColors.yellowColor,
                iconColor: Colors.white,
                disabledIconColor: Colors.grey.shade500,
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: addArticleController.titleController,
                    maxLines: 2,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title here',
                      hintStyle: TextStyle(
                          color: Theme.of(context).textTheme.headline1.color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ZefyrField(
                      controller: addArticleController.zefyrController,
                      focusNode: addArticleController.focusNode,
                      mode: ZefyrMode(
                          canEdit: true, canSelect: true, canFormat: true),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      imageDelegate: EditorAddImage(),
                      toolbarDelegate: EditorToolbar(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
