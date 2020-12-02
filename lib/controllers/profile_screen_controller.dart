import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileScreenController extends GetxController {
  User currentUser;

  @override
  void onInit() {
    currentUser = FirebaseAuth.instance.currentUser;
    super.onInit();
  }

  
}
