import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';
import 'package:sillog/home/screens/home.dart';

class CancelRegisterButton extends StatelessWidget {
  const CancelRegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SillogController sillogController = Get.find<SillogController>();
    return IconButton(
      icon: Icon(Icons.close),
      onPressed: () {
        sillogController.clearController();
        Get.offAll(Home());
      },
    );
  }
}
