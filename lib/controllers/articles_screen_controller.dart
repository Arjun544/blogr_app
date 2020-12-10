import 'package:blogr_app/controllers/add_article_screen_controller.dart';
import 'package:blogr_app/controllers/database_controller/database_controller.dart';
import 'package:blogr_app/models/category_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ArticlesScreenController extends GetxController {
  DatabaseController databaseController = Get.find<DatabaseController>();
  AddArticleController addArticleController = Get.find<AddArticleController>();
  User currentUser;
  CategoryModel categoryModel = CategoryModel();
  var selectedIndex = 0.obs.toInt();
  var file;

  @override
  void onInit() {
    currentUser = FirebaseAuth.instance.currentUser;
    super.onInit();
  }

  void bookMarkArticle(String articleId) async {
    await databaseController.bookMarkArticle(
      articleId: articleId,
      userId: currentUser.uid,
    );
    update();
  }

  void deleteArticle(String articleId) async {
    await databaseController.deleteArticle(articleId);
    update();
  }

  void commentOnArticle(String commentText, String articleId) async {
    await databaseController.commentOnArticle(
      userId: currentUser.uid,
      articleId: articleId,
      commentBy: currentUser.displayName,
      profilePic: currentUser.photoURL,
      commentText: commentText,
    );
    update();
  }

  likeArticle(String articleId) async {
    await databaseController.likeArticle(currentUser.uid, articleId);
    update();
  }

  void updateCategory(int index) {
    selectedIndex = index;
    update();
  }
}
