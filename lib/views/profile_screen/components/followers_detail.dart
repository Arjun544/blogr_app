import 'package:blogr_app/controllers/articles_screen_controller.dart';
import 'package:blogr_app/controllers/profile_screen_controller.dart';
import 'package:blogr_app/views/users_profile_screen/components/follow_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class FollowersDetail extends StatelessWidget {
  final bool isFollowers;

  FollowersDetail({@required this.isFollowers});

  final ProfileScreenController profileScreenController =
      Get.find<ProfileScreenController>();
  final ArticlesScreenController articlesScreenController =
      Get.find<ArticlesScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: isFollowers == true
            ? Text(
                'Followers',
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).textTheme.headline1.color),
              )
            : Text(
                'Followings',
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).textTheme.headline1.color),
              ),
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: isFollowers == true
              ? FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection('followers')
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection('followings')
                  .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData && snapshot.data == null) {
              return Center(
                child: Lottie.asset('assets/loading.json'),
              );
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
                      'No body yet',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).textTheme.headline1.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.docs.length,
                padding: EdgeInsets.only(top: 20),
                itemBuilder: (context, index) {
                  dynamic followersData = snapshot.data.docs[index];

                  return Container(
                    height: Get.height * 0.11,
                    color: Theme.of(context).backgroundColor,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: CachedNetworkImageProvider(
                                        followersData['profile_photo']),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    followersData['username'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          .color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FollowButton(
                              height: 40,
                              width: 120,
                              userData: followersData,
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey.withOpacity(0.4),
                          thickness: 2,
                          indent: 85,
                        ),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
