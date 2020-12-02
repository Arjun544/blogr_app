import 'package:flutter/material.dart';

class CategoryModel {
  final String txt;
  final IconData icon;

  CategoryModel({this.txt, this.icon});
}

List<CategoryModel> categories = [
  CategoryModel(txt: 'All', icon: Icons.all_inclusive_sharp),
  CategoryModel(txt: 'Culture', icon: Icons.all_inclusive_sharp),
  CategoryModel(txt: 'Coding', icon: Icons.all_inclusive_sharp),
  CategoryModel(txt: 'Life', icon: Icons.all_inclusive_sharp),
  CategoryModel(txt: 'Science', icon: Icons.all_inclusive_sharp),
  CategoryModel(txt: 'Travel', icon: Icons.all_inclusive_sharp),
  CategoryModel(txt: 'Health', icon: Icons.all_inclusive_sharp),
  CategoryModel(txt: 'Others', icon: Icons.all_inclusive_sharp),
];
