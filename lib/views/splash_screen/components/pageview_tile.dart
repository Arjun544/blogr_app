import 'dart:ui';

import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/models/splash_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'container_painter.dart';

class PageViewTile extends StatelessWidget {
  final SplashModel splashList;
  final Animation<Offset> cardAnimation;
  final Animation<Offset> textAnimation;

  const PageViewTile({this.splashList, this.cardAnimation, this.textAnimation});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return ClipRRect(
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: CustomPaint(
            painter: ContainerPainter(
                color: CustomColors.yellowColor.withOpacity(0.3),
                avatarRadius: 48),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 7,
                sigmaY: 7,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    SlideTransition(
                      position: cardAnimation,
                      child: Lottie.asset(
                        splashList.src,
                        fit: BoxFit.cover,
                        height: screenHeight * 0.3,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: SlideTransition(
                        position: textAnimation,
                        child: Text(
                          splashList.txt,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22,
                              color: CustomColors.blackColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
