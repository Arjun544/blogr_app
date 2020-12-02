import 'dart:math';
import 'package:blogr_app/models/splash_model.dart';
import 'package:blogr_app/views/home_screen/home_screen.dart';
import 'package:blogr_app/views/splash_screen/components/page_button.dart';
import 'package:blogr_app/views/splash_screen/components/pageview_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/top_row.dart';

class SplashScreen extends StatefulWidget {
  static final String routeName = 'splash screen';
  const SplashScreen({Key key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _pageIndicatorAnimationController;
  AnimationController _cardsAnimationController;
  Animation<double> _pageIndicatorAnimation;
  Animation animation;
  Animation<Offset> _slideAnimationCard;
  Animation<Offset> _slideAnimationText;
  Animation _curveAnimation;
  PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _pageIndicatorAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _cardsAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _setPageIndicatorAnimation();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.addListener(() {
      setState(() {});
    });
    _pageIndicatorAnimationController.addListener(() {
      setState(() {});
    });

    _setCardsSlideOutAnimation();
    _curveAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeOut,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(_curveAnimation);

    if (_pageIndicatorAnimation.status == AnimationStatus.dismissed) {
      _pageIndicatorAnimationController.forward();
    }

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    super.initState();
  }

  void _setCardsSlideInAnimation() {
    setState(() {
      _slideAnimationCard = Tween<Offset>(
        begin: Offset(3.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _cardsAnimationController,
        curve: Curves.easeOut,
      ));
      _slideAnimationText = Tween<Offset>(
        begin: Offset(1.5, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _cardsAnimationController,
        curve: Curves.easeOut,
      ));
      _cardsAnimationController.reset();
    });
  }

  void _setCardsSlideOutAnimation() {
    setState(() {
      _slideAnimationCard = Tween<Offset>(
        begin: Offset.zero,
        end: Offset(-3.0, 0.0),
      ).animate(CurvedAnimation(
        parent: _cardsAnimationController,
        curve: Curves.easeIn,
      ));
      _slideAnimationText = Tween<Offset>(
        begin: Offset.zero,
        end: Offset(-1.5, 0.0),
      ).animate(CurvedAnimation(
        parent: _cardsAnimationController,
        curve: Curves.easeIn,
      ));
      _cardsAnimationController.reset();
    });
  }

  void _setPageIndicatorAnimation({bool isClockwiseAnimation = true}) {
    var multiplicator = isClockwiseAnimation ? 2 : -2;

    setState(() {
      _pageIndicatorAnimation = Tween(
        begin: 0.0,
        end: multiplicator * pi,
      ).animate(
        CurvedAnimation(
          parent: _pageIndicatorAnimationController,
          curve: Curves.easeIn,
        ),
      );
      _pageIndicatorAnimationController.reset();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _cardsAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    _animationController.forward();
    _pageIndicatorAnimationController.forward();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 30, left: 30),
              child: const TopRow(),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 40),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: screenHeight * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (value) {
                            currentPage = value;
                            _animationController.reset();
                            _pageIndicatorAnimationController.reset();
                          },
                          itemCount: splashList.length,
                          itemBuilder: (context, index) {
                            return PageViewTile(
                              cardAnimation: _slideAnimationCard,
                              textAnimation: _slideAnimationText,
                              splashList: splashList[index],
                            );
                          }),
                    ),
                    Positioned(
                      bottom: 35,
                      child: PageButton(
                        onPressed: currentPage == 2
                            ? () {
                                Get.offNamed(HomeScreen.routeName);
                              }
                            : () async {
                                await _cardsAnimationController.forward();
                                _pageController.nextPage(
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeIn);
                                _setCardsSlideInAnimation();
                                await _cardsAnimationController.forward();
                                _setCardsSlideOutAnimation();
                              },
                        animation: animation,
                        currentPage: currentPage,
                        pageIndicatorAnimation: _pageIndicatorAnimation,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
