import 'package:blogr_app/controllers/root_screen.dart';
import 'package:blogr_app/views/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_screen/home_screen.dart';

enum AuthStatus { notLoggedIn, loggedIn }

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final RootScreenController rootScreenController =
      Get.find<RootScreenController>();
  AuthStatus _authStatus = AuthStatus.notLoggedIn;
  User currentUser;

  @override
  void initState() {
    currentUser = rootScreenController.currentUser;
    onStartup();
    super.initState();
  }

  void onStartup() async {
    setState(() {
      if (currentUser != null) {
        _authStatus = AuthStatus.loggedIn;
      } else {
        setState(() {
          _authStatus = AuthStatus.notLoggedIn;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = LoginScreen();
        break;
      case AuthStatus.loggedIn:
        retVal = HomeScreen();
        break;
      default:
    }
    return retVal;
  }
}
