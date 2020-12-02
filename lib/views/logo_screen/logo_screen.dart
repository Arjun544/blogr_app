import 'dart:async';
import 'dart:ui';

import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/views/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _fadeAnimation;
  Animation<Offset> _slideOne;
  Animation<Offset> _slideTwo;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    _scaleAnimation = Tween(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(curve: Curves.easeOut, parent: _controller));
    _fadeAnimation = Tween(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(curve: Curves.easeOut, parent: _controller));
    _slideOne =
        Tween(begin: Offset.zero, end: Offset(1, 0)).animate(_controller);
    _slideTwo =
        Tween(begin: Offset.zero, end: Offset(-6.5, 0)).animate(_controller);
    Timer(Duration(seconds: 2), () {
      _controller.forward();
    });
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.blackColor,
      body: Stack(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SlideTransition(
                  position: _slideOne,
                  child: Text(
                    'B',
                    style: TextStyle(
                        color: CustomColors.yellowColor,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      'logr',
                      style: TextStyle(
                          color: CustomColors.yellowColor,
                          fontSize: 60,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SlideTransition(
                  position: _slideTwo,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 13),
                    height: 10,
                    width: 10,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
