import 'package:blogr_app/controllers/auth_controller/auth_controller.dart';
import 'package:blogr_app/views/login_screen/login_screen.dart';
import 'package:blogr_app/views/profile_screen/components/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsTab extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dark mode',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            CustomSwitch(),
          ],
        ),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Receive notificatons',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            CustomSwitch(),
          ],
        ),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Logout',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await authController.signOut();
                  Get.toNamed(LoginScreen.routeName);
                }),
          ],
        ),
      ],
    );
  }
}
