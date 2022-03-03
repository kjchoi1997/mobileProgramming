import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sillog/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 다음으로 이동하는 버튼
class BottomButton extends StatelessWidget {
  BottomButton({required this.text, required this.onPressed, color}) {
    this.color = color ?? SLG_COLOR;
  }

  final String text;
  Color? color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 30.0),
        child: ElevatedButton(
            child: Text(
              text,
              style: ButtonText.bottomButton,
            ),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 13),
                minimumSize: Size(double.infinity, 0),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                primary: color ?? SLG_COLOR),
            onPressed: onPressed),
      ),
    );
  }
}

// 다음으로 이동하는 버튼
class SendButton extends StatelessWidget {
  SendButton({required this.text, required this.onPressed, color}) {
    this.color = color ?? SLG_COLOR;
  }

  final String text;
  Color? color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Text(
          text,
          style: ButtonText.bottomButton,
        ),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 13),
            minimumSize: Size(150, 55),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            primary: color ?? SLG_COLOR),
        onPressed: onPressed);
  }
}

class BottomRecButton extends StatelessWidget {
  //라운딩 x 버튼
  BottomRecButton({required this.text, required this.onPressed, color}) {
    this.color = color ?? SLG_COLOR;
  }

  final String text;
  Color? color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ElevatedButton(
          child: Text(
            text,
            style: ButtonText.bottomButton,
          ),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 13),
              minimumSize: Size(double.infinity, 0),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(0.0),
              ),
              primary: color ?? SLG_COLOR),
          onPressed: onPressed),
    );
  }
}

// 파일 첨부나, 사진 첨부할때 버튼
class PickerButton extends StatelessWidget {
  PickerButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.icon,
  }) : super(key: key);

  final String text;
  Widget? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      width: 80.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
                side: BorderSide(color: SLG_COLOR)),
            primary: Colors.white),
        onPressed: onPressed,
        child: icon == null
            ? Text(
                text,
                style: ButtonText.pickerButton,
                textAlign: TextAlign.center,
              )
            : Row(
                children: [
                  icon!,
                  Text(
                    text,
                    style: ButtonText.pickerButton,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
      ),
    );
  }
}
