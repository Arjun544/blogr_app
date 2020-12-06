import 'package:blogr_app/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileTile extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  const ProfileTile({@required this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Center(
          child: Container(
            height: screenHeight * 0.18,
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.35,
                top: screenHeight * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          documentSnapshot.data()['title'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ).copyWith(
                              color:
                                  Theme.of(context).textTheme.headline1.color),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            documentSnapshot.data()['likes'].length.toString(),
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
                            documentSnapshot.data()['comments'].toString(),
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
                            color: CustomColors.greyColor.withOpacity(0.7),
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
          margin: EdgeInsets.fromLTRB(30, 0, 10, 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                documentSnapshot.data()['imageUrl'],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
