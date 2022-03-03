import 'package:flutter/material.dart';
import 'package:sillog/home/controller/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sillog/data/provider/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sillog/home/screens/home.dart';
import 'package:sillog/home/screens/login_page.dart';

class Loading extends StatelessWidget {
  // 실록 로딩 페이지

  //실록 로그인
  Future<void> _sillogSignIn() async {
    final userController = Get.find<UserController>();
    final user = FirebaseAuth.instance.currentUser!;
    try {
      http.Response signInResponse = await ApiClient().postApi(
          'api/v1/members/login',
          {'Content-type': 'application/json', 'Accept': 'application/json'},
          {'id': '${user.uid}', 'email': '${user.email}'}); //실록 로그인

      //실록 로그인 성공
      if (signInResponse.statusCode == 200) {
        Map<String, dynamic> loginResponseBody =
            jsonDecode(utf8.decode(signInResponse.bodyBytes));
        print('Response body: $loginResponseBody');
        userController.jwt =
            loginResponseBody['data']['accessToken'].toString();
        print(userController.jwt);
        http.Response userResponse =
            await ApiClient().getApi('api/v1/members/me', {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'X-AUTH-TOKEN': '${userController.jwt}'
        });

        //실록 사용자 정보
        print('Response status: ${userResponse.statusCode}');
        print('Response body: ${utf8.decode(userResponse.bodyBytes)}');

        //실록 사용자 정보 조회 성공
        if (userResponse.statusCode == 200) {
          Map<String, dynamic> userResponseBody =
              jsonDecode(utf8.decode(userResponse.bodyBytes));
          userController.id = userResponseBody['data']['id'].toString();
        }

        //실록 사용자 정보 조회 실패
        else {
          Get.snackbar('실록 로그인', '사용자 정보를 가져올 수 없습니다.',
              snackPosition: SnackPosition.TOP);
        }
      }

      //실록 로그인 성공, 회원가입 x
      else if (signInResponse.statusCode == 404) {
        Get.snackbar('실록 로그인', '회원가입이 필요한 유저입니다.',
            snackPosition: SnackPosition.TOP);
        _sillogSignUp(); //실록 회원가입
        print('Response body: ${utf8.decode(signInResponse.bodyBytes)}');
      }

      //실록 로그인 실패
      else {
        Get.snackbar('실록 로그인', '로그인이 실패하였습니다. 다시 시도해주세요.',
            snackPosition: SnackPosition.TOP);
        print('Response body: ${utf8.decode(signInResponse.bodyBytes)}');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _sillogSignUp() async {
    final userController = Get.find<UserController>();
    final user = FirebaseAuth.instance.currentUser!;

    //실록 회원가입
    // TODO : 회원가입 페이지 제작 email?
    try {
      http.Response signUpResponse =
          await ApiClient().postApi('api/v1/members/signup', {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      }, {
        "email": "${user.email}",
        "nickname": "test",
        "password": "1234",
        "birth": "2021-07-21",
        "profileImage": "/test.jpg",
        "gender": "male"
      });

      //실록 회원가입
      if (signUpResponse.statusCode == 201) {
        Map<String, dynamic> responseBody =
            jsonDecode(utf8.decode(signUpResponse.bodyBytes));
        userController.jwt = responseBody['data']['accessToken'].toString();
        print(userController.jwt);
        print('Response body: ${utf8.decode(signUpResponse.bodyBytes)}');
        Get.offAll(() => Home(), transition: Transition.rightToLeftWithFade);
      } else if (signUpResponse.statusCode == 400) {
        Get.snackbar('실록 회원가입', '이미 회원가입 된 유저입니다.',
            snackPosition: SnackPosition.TOP);
        print('Response body: ${utf8.decode(signUpResponse.bodyBytes)}');
      } else {
        Get.snackbar('실록 회원가입', '회원가입이 실패하였습니다. 다시 시도해주세요.',
            snackPosition: SnackPosition.TOP);
        print('Response body: ${utf8.decode(signUpResponse.bodyBytes)}');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 로그인을 진행
    // _sillogSignIn();

    // 로그인 완료시 컨트롤러 설정
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Image.asset('assets/image/sillog_logo.png'));
        } else if (snapshot.hasData) {
          _sillogSignIn();
          return Home();
        } else if (snapshot.hasError) {
          return Center(child: Text('문제가 있습니다'));
        } else {
          return LoginPage();
        }
      },
    );
  }
}
