import 'package:flutter/material.dart';
import 'package:sillog/utils/app_colors.dart';
import 'package:sillog/utils/app_text_theme.dart';

class ChipButton extends StatelessWidget {
  //버튼 칩스
  ChipButton({required this.text, icon, color, required this.onPressed}) {
    this.color = color ?? SLG_COLOR;
    this.icon = icon ?? null;
  }

  final String text;
  Color? color;
  IconData? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0),
              side: BorderSide(color: SLG_COLOR)),
          primary: Colors.white),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon != null
              ? Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              Icons.camera_alt,
              color: color,
            ),
          )
              : SizedBox(width: 0),
          Center(
            child: Text(
              text,
              style: RegText.PRIMARY_TEXT,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}