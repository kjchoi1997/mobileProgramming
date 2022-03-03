import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:sillog/utils/utils.dart';

class SLG_Dialog {
  SLG_Dialog();

  static void defaultDialog(
      {required title,
      required middleText,
      textConfirm,
      textCancel,
      onCancel,
      required onConfirm}) {
    String _middleText = middleText;
    var _title = title;
    var _textConfirm = textConfirm ?? '확인';
    var _textCancel = textCancel ?? '취소';
    var _onConfirm = onConfirm;
    var _onCancel = onCancel ?? () {};

    Get.defaultDialog(
      title: _title,
      titleStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      middleText: _middleText,
      middleTextStyle: TextStyle(fontSize: 15, color: Colors.black26),
      backgroundColor: Colors.white,
      radius: 20,
      textCancel: _textCancel,
      cancelTextColor: Colors.black26,
      textConfirm: _textConfirm,
      confirmTextColor: Colors.white,
      buttonColor: SLG_COLOR,
      onCancel: _onCancel,
      onConfirm: _onConfirm,
    );
  }

  static void apologizeDialog(
      {required title,
      required middleText,
      textConfirm,
      textCancel,
      onConfirm}) {
    String _middleText = middleText;
    var _title = title;

    Get.defaultDialog(
      title: _title,
      titleStyle: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: SLG_COLOR),
      middleText: _middleText,
      middleTextStyle: TextStyle(fontSize: 15, color: Colors.black),
      backgroundColor: Colors.white,
      radius: 10,
      titlePadding: EdgeInsets.only(top: 30),
      contentPadding: EdgeInsets.all(30),
      cancelTextColor: Colors.black26,
      buttonColor: Colors.white,
      confirm: TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text(
          '확 인',
          style: TextStyle(
            color: SLG_COLOR,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  static void checkDialog(
      {required title,
      required middleText,
      textConfirm,
      textCancel,
      onPressed}) {
    String _middleText = middleText;
    var _title = title;

    Get.defaultDialog(
      title: _title,
      titleStyle: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: SLG_COLOR),
      middleText: _middleText,
      middleTextStyle: TextStyle(fontSize: 15, color: Colors.black),
      backgroundColor: Colors.white,
      radius: 10,
      titlePadding: EdgeInsets.only(top: 30),
      contentPadding: EdgeInsets.all(30),
      cancelTextColor: Colors.black26,
      buttonColor: Colors.white,
      confirm: TextButton(
        onPressed: onPressed,
        child: Text(
          '확 인',
          style: TextStyle(
            color: SLG_COLOR,
            fontSize: 16,
          ),
        ),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text(
          '취소',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
