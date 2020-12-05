import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/controllers/articles_controller.dart';
import 'package:blogr_app/models/category_model.dart';
import 'package:blogr_app/views/category_screen/category_screen.dart';
import 'package:blogr_app/views/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 25, top: 20),
          child: Row(
            children: [
              Text(
                'B',
                style: Theme.of(context).appBarTheme.textTheme.headline1,
              ),
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: CustomColors.yellowColor),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25, top: 20),
            child: InkWell(
              onTap: () {
                Get.to(
                  SearchScreen(),
                );
              },
              child: SvgPicture.asset(
                'assets/Search.svg',
                color: Theme.of(context).appBarTheme.iconTheme.color,
                height: 26,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: null,
          child: Container(
            height: 40,
            child: GetBuilder<ArticlesController>(
              init: ArticlesController(),
              builder: (controller) {
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    padding: EdgeInsets.only(left: 18),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.updateCategory(index);
                          if (categories[index].txt == 'All') {
                            return;
                          } else {
                            Get.to(
                              CategoryScreen(
                                category: categories[index],
                              ),
                            );
                          }
                          controller.updateCategory(0);

                          print(categories[index].txt);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30, left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                categories[index].txt,
                                style: TextStyle(
                                  fontSize: 21,
                                  color: controller.selectedIndex == index
                                      ? Theme.of(context).textTheme.headline1.color
                                      : Theme.of(context).textTheme.headline2.color,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                height: 6,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: controller.selectedIndex == index
                                      ? CustomColors.yellowColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
        ),
      ),
    );
  }

  Size get preferredSize => const Size.fromHeight(120);
}
