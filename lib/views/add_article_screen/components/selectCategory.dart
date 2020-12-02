import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/controllers/add_article_screen_controller.dart';
import 'package:blogr_app/views/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SelectCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GetBuilder<AddArticleController>(
              init: AddArticleController(),
              builder: (controller) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Select a category of article :',
                            style: TextStyle(
                              fontSize: 22,
                              color: CustomColors.blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: Get.mediaQuery.size.width * 0.7,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: CustomColors.greyColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  isExpanded: true,
                                  iconEnabledColor: Colors.white,
                                  dropdownColor: Colors.grey,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  value: controller.selectedCategory,
                                  items: <String>[
                                    'All',
                                    'Culture',
                                    'Coding',
                                    'Life',
                                    'Science',
                                    'Travel',
                                    'Health',
                                    'Others'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String value) {
                                    controller.updateCategory(value);
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 90),
                      child: controller.isLoading
                          ? Lottie.asset('assets/loading.json',
                              repeat: true,
                              fit: BoxFit.contain,
                              alignment: Alignment.bottomCenter)
                          : Material(
                              color: CustomColors.blackColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              elevation: 5.0,
                              child: MaterialButton(
                                onPressed: () async {
                                  controller.toggleLoading(true);
                                  await controller.saveArticle();
                                  controller.toggleLoading(false);
                                  Get.toNamed(HomeScreen.routeName);
                                },
                                minWidth: Get.mediaQuery.size.width * 0.7,
                                height: 70.0,
                                child: Text(
                                  'Publish',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
