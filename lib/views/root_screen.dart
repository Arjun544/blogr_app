import 'package:blogr_app/views/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen/home_screen.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  bool isSigned = false;

  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((useraccount) {
      if (useraccount != null) {
        if (this.mounted) {
          setState(() {
            isSigned = true;
          });
        }
      } else {
        if (this.mounted) {
          setState(() {
            isSigned = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSigned == false ? LoginScreen() : HomeScreen(),
    );
  }
}
