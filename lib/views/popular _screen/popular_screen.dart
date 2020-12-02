import 'package:flutter/material.dart';

class PopularScreen extends StatelessWidget {
  static final String routeName = 'popular screen';
  const PopularScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('popular screen'),
      ),
    );
  }
}