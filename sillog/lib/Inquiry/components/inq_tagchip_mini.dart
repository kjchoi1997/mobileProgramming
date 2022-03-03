import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sillog/Registration/data/model/reg_model.dart';
import 'package:sillog/utils/app_colors.dart';

class InqTagChipMini extends StatelessWidget {
  InqTagChipMini(
      {required this.index,
      onTap,
      color,
      required this.tagData,
      required this.length}) {
    this.onTap = onTap ?? () {};
    this.color = color ?? Colors.white;
  }

  final int index;
  VoidCallback? onTap;
  Color? color;
  final List<TagModel> tagData;
  final int length;

  @override
  Widget build(BuildContext context) {
    if (index <= 1) {
      return Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5,
            ),
            child: InkWell(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: SLG_COLOR),
                  borderRadius: new BorderRadius.circular(50.0),
                ),
                child: Text(
                  '# ${tagData[index].tagName}',
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (index == length - 1) {
      return Chip(
        label: Text(
          ("+ ${length - 2}").toString(),
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      );
    } else {
      return Container(
        width: 0,
        height: 0,
      );
    }
  }
}
