import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sillog/utils/utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  Color? color;
  double? step;
  bool? leading;
  Color? backgroundColor;

  var actions;

  CustomAppBar(
      {required this.title, color, step, leading, backgroundColor, actions}) {
    this.step = step ?? 0;
    this.color = color ?? Colors.black;
    this.leading = leading ?? false;
    this.backgroundColor = backgroundColor ?? Colors.white;
    this.actions = actions;
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: title == 'sillog'
            ? Text(title,
                style: TextStyle(
                    color: color, fontFamily: 'Inqlipquid', fontSize: 25))
            : Text(title, style: TextStyle(color: color)),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: backgroundColor,
        actions: actions ?? [],
        bottom: step == 0
            ? null
            : PreferredSize(
                preferredSize: Size(double.infinity, 0.1),
                child: LinearProgressIndicator(
                  color: SLG_COLOR,
                  backgroundColor: Colors.white,
                  value: step,
                ),
              ),
        leading: leading == false
            ? null
            : IconButton(
                onPressed: () => Get.back(),
                color: color,
                icon: Icon(Icons.navigate_before)));
  }
}

class RefAppBar extends StatelessWidget implements PreferredSizeWidget {
  RefAppBar({title}) {
    this.title = title ?? 'sillog';
  }

  String? title;

  @override
  Size get preferredSize => Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF163C6B),
      title: Text(
        '$title',
        style: TextStyle(color: Colors.white),
      ),
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu),
        color: Colors.white,
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
          color: Colors.white,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.open_in_new_outlined),
          color: Colors.white,
        )
      ],
    );
  }
}
