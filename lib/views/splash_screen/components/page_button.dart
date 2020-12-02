import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/views/splash_screen/components/page_indicator.dart';
import 'package:flutter/material.dart';

class PageButton extends StatelessWidget {
  final Animation<double> pageIndicatorAnimation;
  final Animation animation;
  final int currentPage;
  final Function onPressed;

  const PageButton({
    @required this.pageIndicatorAnimation,
    @required this.animation,
    @required this.currentPage,
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
              animation: pageIndicatorAnimation,
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: CustomColors.blackColor,
                  shape: BoxShape.circle,
                ),
                child: currentPage == 2
                    ? Center(
                        child: Text(
                          'Go',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
              ),
              builder: (_, Widget child) {
                return child;
              }),
          FadeTransition(
            opacity: animation,
            child: PageIndicator(
              angle: pageIndicatorAnimation.value,
              currentPage: currentPage,
            ),
          ),
        ],
      ),
    );
  }
}
