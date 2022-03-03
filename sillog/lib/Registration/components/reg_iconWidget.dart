import 'package:flutter/material.dart';
import 'package:sillog/utils/app_colors.dart';

class IconWidget extends StatelessWidget {
  //아이콘 위젯
  IconWidget({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(45.0)),
            color: SLG_COLOR),
        child: Center(
          child: Icon(
            icon,
            size: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
