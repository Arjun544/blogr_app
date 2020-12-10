import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/controllers/database_controller/database_controller.dart';
import 'package:blogr_app/controllers/profile_screen_controller.dart';
import 'package:blogr_app/views/detail_screen/detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ArticlesTab extends StatelessWidget {
  final ProfileScreenController profileScreenController =
      Get.find<ProfileScreenController>();
  final DatabaseController databaseController = Get.find<DatabaseController>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('articles')
          .where('addedBy',
              isEqualTo: profileScreenController.currentUser.displayName)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData && snapshot.data == null) {
          return Lottie.asset('assets/loading.json');
        }
        if (snapshot.data.docs.length == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/no articles.json'),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'No articles',
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.headline1.color,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }
        return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot profileData = snapshot.data.docs[index];
              return InkWell(
                onTap: () {
                  Get.to(
                    DetailScreen(
                      articles: profileData,
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Center(
                      child: Container(
                        height: screenHeight * 0.18,
                        width: screenWidth * 0.9,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .cardColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.36,
                              top: screenHeight * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      profileData.data()['title'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ).copyWith(
                          color: Theme.of(context).textTheme.headline1.color),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      await databaseController.deleteArticle(
                                          profileData.data()['id']);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        profileData
                                            .data()['likes']
                                            .length
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ).copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headline1
                                                .color),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      SvgPicture.asset('assets/Heart.svg',
                                          height: 22, color: Colors.pink),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        profileData
                                            .data()['comments']
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ).copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headline1
                                                .color),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      SvgPicture.asset(
                                        'assets/Chat.svg',
                                        height: 22,
                                        color: CustomColors.greyColor
                                            .withOpacity(0.7),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: screenHeight * 0.2,
                      width: screenWidth * 0.25,
                      margin: EdgeInsets.fromLTRB(50, 10, 10, 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            profileData.data()['imageUrl'],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}
