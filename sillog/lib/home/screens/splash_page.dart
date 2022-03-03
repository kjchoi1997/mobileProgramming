import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sillog/FileManage/controller/file_list_controller.dart';
import 'package:sillog/Inquiry/controller/inq_controller.dart';
import 'package:sillog/Inquiry/controller/tag_list_controller.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';
import 'package:sillog/data/provider/api.dart';
import 'package:sillog/home/controller/user_controller.dart';
import 'package:sillog/home/screens/login_page.dart';
import 'package:sillog/utils/app_colors.dart';
import 'package:sillog/widgets/spinkit.dart';

import 'home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sillog/home/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
          userController.name = user.displayName!;
          userController.email = user.email!;
          userController.photo = user.photoURL!;
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

  Future<void> _deleteAllSillogs() async {
    final userController = Get.find<UserController>();
    final sillogController = Get.find<SillogListController>();

    print('user id : ${userController.id}');
    print('user jwt: ${userController.jwt}');
    for (var sillog in sillogController.sillogsList) {
      var id = sillog.id;
      print('delete $id');
      http.Response sillogResponse = await ApiClient().deleteApi(
          '/api/v1/sillogs/$id', {
        'Content-type': 'application/json',
        'X-AUTH-TOKEN': '${userController.jwt}'
      }); // 실록 전부 제거
      print('Response status(Sillogs): ${sillogResponse.statusCode}');
      if (sillogResponse.statusCode == 204) {
        print('Response body: ${utf8.decode(sillogResponse.bodyBytes)}');
      } else {
        // 만약 요청이 실패하면, 에러를 던짐
        throw Exception('요청 실패');
      }
    }
    return;
  }

  Future<bool> _initialSettings() async {
    Get.put(UserController());

    await _sillogSignIn();

    await Get.put(TitleController()).getTitle();
    await Get.put(SillogListController()).getSillogs();
    await Get.put(TagListController()).getTags();
    Get.put(SillogController());
    Get.put(FileListController());
    Get.put(TagController());
    Get.put(QuestionController());
    Get.put(CountController());

    // await _deleteAllSillogs();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingImage();
          } else if (snapshot.hasData) {
            return FutureBuilder(
                future: _initialSettings(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Home();
                  } else {
                    return LoadingImage();
                  }
                });
          } else {
            return LoginPage();
          }
        });
  }
}

class LoadingImage extends StatelessWidget {
  const LoadingImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 100,
                    height: 165,
                    child: Image.asset('assets/image/sillog_logo.png')),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '나를 기록하고 증명하다',
                    style: TextStyle(
                        color: SLG_COLOR,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        fontFamily: 'SpoqaHanSansNeo'),
                  ),
                ),
                SizedBox(height: 30),
                LOADING_INDICATOR,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
