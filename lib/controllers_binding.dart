import 'package:blogr_app/controllers/add_article_screen_controller.dart';
import 'package:blogr_app/controllers/articles_controller.dart';
import 'package:blogr_app/controllers/auth_controller/auth_controller.dart';
import 'package:blogr_app/controllers/database_controller/database_controller.dart';
import 'package:blogr_app/controllers/home_screen_controller.dart';
import 'package:blogr_app/controllers/login_screen_controller.dart';
import 'package:blogr_app/controllers/profile_screen_controller.dart';
import 'package:blogr_app/controllers/search_screen_controller.dart';
import 'package:blogr_app/controllers/users_profile_screen_controller.dart';
import 'package:get/get.dart';

class ControllersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<DatabaseController>(() => DatabaseController());
    Get.lazyPut<ArticlesController>(() => ArticlesController());
    Get.lazyPut<AddArticleController>(() => AddArticleController());
    Get.lazyPut<LoginScreenController>(() => LoginScreenController());
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
    Get.lazyPut<SearchScreenController>(() => SearchScreenController());
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
    Get.lazyPut<UsersProfileScreenController>(
        () => UsersProfileScreenController());
  }
}
