import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/controllers/articles_controller.dart';
import 'package:blogr_app/controllers/detail_screen_controller.dart';
import 'package:blogr_app/views/detail_screen/components/article_options.dart';
import 'package:blogr_app/views/detail_screen/components/writer_info.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  final DocumentSnapshot articles;

  DetailScreen({@required this.articles});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final DetailScreenController detailScreenController =
      Get.find<DetailScreenController>();

      ScrollController _hideBottomNavController;
      bool _isVisible = false;

  @override
  initState() {
    super.initState();
    _isVisible = true;
    _hideBottomNavController = ScrollController();
    _hideBottomNavController.addListener(
      () {
        if (_hideBottomNavController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (_isVisible)
            setState(() {
              _isVisible = false;
            });
        }
        if (_hideBottomNavController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!_isVisible)
            setState(() {
              _isVisible = true;
            });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: CustomColors.blackColor),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: SvgPicture.asset(
                'assets/Setting.svg',
                height: 25,
              ),
            ),
          ],
        ),
        bottomNavigationBar: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: _isVisible ? 60.0 : 0.0,
                width: _isVisible ? screenWidth : 0.0,
                color: Colors.grey[200],
                child: ArticleOptions(
                  articles: widget.articles,
                ),
              ),
        body: CustomScrollView(
          controller: _hideBottomNavController,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 30,
                        left: 30,
                      ),
                      child: WriterInfo(
                        articles: widget.articles,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 30,
                        left: 30,
                      ),
                      child: Text(
                        toBeginningOfSentenceCase(
                          widget.articles.data()['title'],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.blackColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 30,
                        left: 30,
                      ),
                      child: Divider(
                        color: Colors.blueGrey.withOpacity(0.1),
                        thickness: 2,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CachedNetworkImage(
                      imageUrl: widget.articles.data()['imageUrl'],
                      fit: BoxFit.cover,
                      height: Get.mediaQuery.size.height * 0.3,
                      width: Get.mediaQuery.size.width,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, right: 30, left: 30, bottom: 15),
                      child: SelectableText(
                        widget.articles.data()['desc'],
                        toolbarOptions:
                            ToolbarOptions(copy: true, selectAll: true),
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.7),
                        ),
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
