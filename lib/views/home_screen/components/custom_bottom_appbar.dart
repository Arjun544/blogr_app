import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/controllers/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BottomAppBarItem {
  const BottomAppBarItem({this.icon});
  final String icon;
}

class CustomBottomAppBar extends StatefulWidget {
  CustomBottomAppBar({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.color,
    this.backgroundColor,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 3);
  }
  final List<BottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => CustomBottomAppBarState();
}

class CustomBottomAppBarState extends State<CustomBottomAppBar> {
  final HomeScreenController homeScreenController = Get.find();

  _updateIndex(int index) {
    widget.onTabSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    return BottomAppBar(
      shape: widget.notchedShape,
      elevation: Theme.of(context).bottomNavigationBarTheme.elevation,
      notchMargin: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildTabItem({
    BottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = homeScreenController.currentIndex == index
        ? widget.selectedColor
        : widget.color;
    return SizedBox(
      height: widget.height,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            onPressed(index);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SvgPicture.asset(
                  '${item.icon}',
                  height: 30,
                  color: color,
                  fit: BoxFit.cover,
                ),
              ),
              homeScreenController.currentIndex == index
                  ? Container(
                      height: 8,
                      width: 8,
                      margin: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        color: CustomColors.yellowColor,
                        shape: BoxShape.circle,
                      ),
                    )
                  : Container(
                      height: 8,
                      width: 8,
                      margin: EdgeInsets.only(top: 5),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
