import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sillog/home/components/sns_login_btn.dart';
import 'package:sillog/home/controller/user_controller.dart';
import 'package:sillog/home/screens/splash_page.dart';

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SSOLoginBtn(
      icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
      text: '구글로 시작하기',
      onPressed: () async {
        try {
          // UserCredential userCredential =
          //     await GoogleSignInController.googleLogin();

          await Get.put(UserController()).login('google');
          Get.offAll(SplashScreen());
        } catch (e) {
          print(e);
        }
      },
    );
  }
}
