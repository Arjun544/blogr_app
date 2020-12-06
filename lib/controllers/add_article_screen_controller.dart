import 'package:blogr_app/controllers/database_controller/database_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class AddArticleController extends GetxController {
  final DatabaseController databaseController = Get.find<DatabaseController>();
  
  ZefyrController zefyrController;
  TextEditingController titleController = TextEditingController();
  FocusNode focusNode;
  User currentUser;
  NotusDocument document;
  var file;
  List<DropdownMenuItem<String>> categoriesItems;
  String selectedCategory = 'Others';
  bool isLoading = false;
  String articleImage = '';
  String noImageUrl =
      'https://img.freepik.com/free-vector/retro-abstract-ornamental-flowers-background_23-2148370307.jpg?size=626&ext=jpg';

  @override
  void onInit() {
    currentUser = FirebaseAuth.instance.currentUser;
    document = _loadDocument();
    zefyrController = ZefyrController(document);
    focusNode = FocusNode();
    super.onInit();
  }

  @override
  void onClose() {
    zefyrController.dispose();
    titleController.dispose();
    super.onClose();
  }

  void toggleLoading(bool loading) {
    isLoading = loading;
    update();
  }

  void updateCategory(String value) {
    selectedCategory = value;
    update();
  }

  Future<void> uploadArticleImage() async {
    try {} catch (e) {
      print(e);
    }
  }

  NotusDocument _loadDocument() {
    final Delta delta = Delta()..insert('Description here\n');
    return NotusDocument.fromDelta(delta);
  }

  saveArticle() async {
    
    articleImage = file == null
        ? noImageUrl
        : await databaseController.uploadArticleImage(currentUser.uid, file);
    databaseController.saveArticle(
      userId: currentUser.uid,
      searchKey: titleController.text[0],
      title: titleController.text,
      addedBy: currentUser.displayName,
      authorPic: currentUser.photoURL,
      desc: document.toPlainText(),
      imageUrl: articleImage,
      category: selectedCategory,
    );
  }
}
