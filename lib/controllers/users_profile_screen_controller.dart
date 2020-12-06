import 'package:blogr_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UsersProfileScreenController extends GetxController {
  Future<UserModel> userData;
}
