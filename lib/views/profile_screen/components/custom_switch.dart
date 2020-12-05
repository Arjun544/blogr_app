import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/controllers/profile_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSwitch extends StatefulWidget {
  final Function onPressed;
  final bool value;

  const CustomSwitch({@required this.onPressed,@required this.value});
  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  final ProfileScreenController profileScreenController =
      Get.find<ProfileScreenController>();
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: CupertinoSwitch(
        value: widget.value,
        trackColor: CustomColors.greyColor,
        onChanged: (value) {
          setState(() {
            profileScreenController.isChecked.value = value;
          });
          widget.onPressed();
        },
      ),
    );
  }
}
