import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/views/articles_screen/components/reading_time.dart';
import 'package:blogr_app/views/detail_screen/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SearchResults extends StatelessWidget {
  final data;

  const SearchResults({this.data});

  @override
  Widget build(BuildContext context) {
    var readTime = readingTime(data['desc']);
    return InkWell(
      onTap: () {
        Get.to(
          DetailScreen(
            articles: data,
          ),
        );
      },
      child: Container(
        height: Get.mediaQuery.size.height * 0.24,
        width: Get.mediaQuery.size.width * 0.8,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: Get.mediaQuery.size.width * 0.65,
                  ),
                  child: Text(
                    data['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 22,
                      color: CustomColors.blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Image.network(
                  data['imageUrl'],
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                    data['authorPic'],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: data['addedBy'],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: CustomColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: ' in ',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: CustomColors.greyColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                text: data['category'],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: CustomColors.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormat.MMMEd().format(
                            data['addedOn'].toDate(),
                          ),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.greyColor,
                          ),
                        ),
                        Container(
                          height: 5,
                          width: 5,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                        ),
                        Text(
                          readTime['text'],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.greyColor,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
