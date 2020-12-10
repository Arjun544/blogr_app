import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileScreenController extends GetxController {
  User currentUser;
  RxBool isChecked = false.obs;
  GetStorage getStorage = GetStorage();
  

  @override
  void onInit() {
    currentUser = FirebaseAuth.instance.currentUser;

    if (getStorage.read('stateValue') != null) {
      isChecked.value = getStorage.read('stateValue');
    }
    super.onInit();
  }

  void saveSwitchState() {
    getStorage.write('stateValue', isChecked.value);
  }
}
