import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sillog/utils/app_colors.dart';

class SLG_Snackbar {
  static alertSnackBar(String message) {
    return Get.snackbar('실록 알림', message,
        backgroundColor: Colors.grey.shade50,
        icon: Icon(Icons.warning_amber_outlined),
        snackPosition: SnackPosition.BOTTOM);
  }
}
