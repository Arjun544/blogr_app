import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/controllers/database_controller/database_controller.dart';
import 'package:blogr_app/controllers/users_profile_screen_controller.dart';
import 'package:blogr_app/models/user_model.dart';
import 'package:blogr_app/views/detail_screen/detail_screen.dart';
import 'package:blogr_app/views/users_profile_screen/components/profile_tile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class UsersProfile extends StatelessWidget {
  static final String routeName = 'usersProfile screen';
  final String user;

  UsersProfile({@required this.user});

  final DatabaseController databaseController = Get.find<DatabaseController>();
  final UsersProfileScreenController usersProfileScreenController =
      Get.find<UsersProfileScreenController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: FutureBuilder<UserModel>(
          future: databaseController.getUserDetailsById(user),
          builder: (context, snapshot) {
            if (!snapshot.hasData && snapshot.data == null) {
              return Center(
                child: Lottie.asset('assets/loading.json'),
              );
            }
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
                      snapshot.data.username,
                      style: TextStyle(fontSize: 18),
                    ),
                    centerTitle: true,
                    background: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            'https://media.istockphoto.com/vectors/abstract-black-background-geometric-texture-vector-id936834172?k=6&m=936834172&s=612x612&w=0&h=oF8_qU5HuultCXfI7KZANZcJBf9VZMuz177kpgEnMcc=',
                            fit: BoxFit.cover,
                          ),
                        ),
                        CircleAvatar(
                          radius: 60.0,
                          backgroundImage: CachedNetworkImageProvider(
                              snapshot.data.profilePhoto),
                          backgroundColor: Colors.transparent,
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
                          .where('addedBy', isEqualTo: snapshot.data.username)
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
                                    ' Published artciles',
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
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
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
