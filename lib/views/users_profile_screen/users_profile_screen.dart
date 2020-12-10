import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/controllers/database_controller/database_controller.dart';
import 'package:blogr_app/controllers/users_profile_screen_controller.dart';
import 'package:blogr_app/views/detail_screen/detail_screen.dart';
import 'package:blogr_app/views/users_profile_screen/components/follow_button.dart';
import 'package:blogr_app/views/users_profile_screen/components/profile_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class UsersProfileScreen extends StatelessWidget {
  static final String routeName = 'usersProfile screen';
  final String user;

  UsersProfileScreen({@required this.user});

  final DatabaseController databaseController = Get.find<DatabaseController>();
  final UsersProfileScreenController usersProfileScreenController =
      Get.find<UsersProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: FutureBuilder(
          future:
              FirebaseFirestore.instance.collection('users').doc(user).get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData && snapshot.data == null) {
              return Center(
                child: Lottie.asset('assets/loading.json'),
              );
            }
            DocumentSnapshot userData = snapshot.data;
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: CustomColors.blackColor,
                  floating: true,
                  snap: true,
                  pinned: true,
                  stretch: true,
                  expandedHeight: 250,
                  iconTheme: IconThemeData(color: Colors.white),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      userData['username'],
                      style: TextStyle(
                          fontSize: 22, color: Colors.white),
                    ),
                    centerTitle: true,
                    background: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/profile_back.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage: CachedNetworkImageProvider(
                                userData['profile_photo']),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  // TabBarView, the remaining supplement)
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('articles')
                          .where('addedBy', isEqualTo: userData['username'])
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData && snapshot.data == null) {
                          return Center(
                              child: Lottie.asset('assets/loading.json'));
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Artciles',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline1
                                            .color,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 35,
                                    width: 35,
                                    margin: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          .color,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      snapshot.data.docs.length.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline3
                                            .color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        FollowButton(
                                          userData: userData,
                                          height: 48,
                                          width: 160,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot documentSnapshot =
                                          snapshot.data.docs[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            DetailScreen(
                                                articles: documentSnapshot),
                                          );
                                        },
                                        child: ProfileTile(
                                            documentSnapshot: documentSnapshot),
                                      );
                                    }),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
