import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/controllers/auth_controller/auth_controller.dart';
import 'package:blogr_app/controllers/database_controller/database_controller.dart';
import 'package:blogr_app/controllers/login_screen_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  static final String routeName = 'login screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final DatabaseController databaseController = Get.find<DatabaseController>();

  final LoginScreenController loginScreenController =
      Get.find<LoginScreenController>();

  final AuthController authController = Get.find<AuthController>();
  bool isLogging = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomColors.blackColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Lottie.asset('assets/book.json',
                  fit: BoxFit.cover, width: screenWidth * 0.6),
              Expanded(
                child: Text(
                  'Log in to access thousands of articles and meet with people of your interests.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
              isLogging
                  ? Visibility(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () async {
                          setState(() {
                            isLogging = true;
                          });
                          authController.signInWithGoogle().whenComplete(() {
                            databaseController
                                .addDataToDb(FirebaseAuth.instance.currentUser);
                            // Navigator.of(context).pushAndRemoveUntil(
                            //     MaterialPageRoute(
                            //       builder: (context) => HomeScreen(),
                            //     ),
                            //     (Route<dynamic> route) => false);
                          }).catchError((onError) {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          });
                        },
                        height: screenHeight * 0.09,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/google.png',
                              height: 30,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Log in With Google',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
