import 'package:blogr_app/controllers/database_controller/database_controller.dart';
import 'package:blogr_app/controllers/users_profile_screen_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowButton extends StatelessWidget {
  final DocumentSnapshot userData;
  final double height;
  final double width;

  FollowButton({
    @required this.userData,
    @required this.height,
    @required this.width,
  });

  final UsersProfileScreenController usersProfileScreenController =
      Get.find<UsersProfileScreenController>();
  final DatabaseController databaseController = Get.find<DatabaseController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(usersProfileScreenController.currentUser.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData && snapshot.data == null) {
            return SizedBox();
          }

          return InkWell(
            onTap: () async {
              await databaseController.userFollowings(
                id: usersProfileScreenController.currentUser.uid,
                userId: userData['uid'],
                displayName: userData['username'],
                email: userData['email'],
                profilePic: userData['profile_photo'],
              );
              await databaseController.userFollowers(
                id: userData['uid'],
                userId: usersProfileScreenController.currentUser.uid,
                displayName:
                    usersProfileScreenController.currentUser.displayName,
                email: usersProfileScreenController.currentUser.email,
                profilePic: usersProfileScreenController.currentUser.photoURL,
              );
            },
            child: Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: snapshot.data.data()["following"].contains(
                          userData['uid'],
                        )
                    ? Colors.green
                    : Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green, width: 2),
              ),
              child: Text(
                snapshot.data.data()["following"].contains(
                          userData['uid'],
                        )
                    ? 'Following'
                    : 'Follow',
                style: TextStyle(
                  color: snapshot.data.data()["following"].contains(
                            userData['uid'],
                          )
                      ? Colors.white
                      : Colors.green,
                  fontSize: 19,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        });
  }
}
