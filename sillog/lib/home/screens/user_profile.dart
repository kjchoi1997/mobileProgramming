import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';
import 'package:sillog/home/controller/user_controller.dart';
import 'package:sillog/home/screens/login_page.dart';
import 'package:sillog/utils/app_colors.dart';
import 'package:sillog/utils/app_text_theme.dart';
import 'package:sillog/widgets/appbar.dart';

class UserProfile extends StatelessWidget {
  final userController = Get.find<UserController>();
  final countController = Get.find<CountController>();

  Widget profile() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(userController.photo),
                          fit: BoxFit.fill,
                        ),
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(45),
                        )),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child:
                          Text('${userController.name}', style: ThemeText.p1),
                    ),
                    Text('${userController.email}', style: userText.INFO_TEXT)
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 0.9.sw,
            height: 50,
            decoration: BoxDecoration(
                color: SLG_COLOR,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '작성한 실록의 수',
                    style: ThemeText_white.p1,
                  ),
                  Obx(
                    () => Text(
                      '${countController.count.obs}개',
                      style: ThemeText_white.p1,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  Widget logout() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Container(
        color: Colors.white,
        height: 50,
        child: TextButton(
          onPressed: () async {
            // final provider =
            //     Provider.of<GoogleSignInProvider>(context, listen: false);
            try {
              await Get.find<UserController>().logout();
              // 초기화 진행
              Get.deleteAll();
              Get.offAll(LoginPage());
            } catch (e) {}
          },
          child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  '로그아웃',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: fontNameDefault,
                    fontSize: 16,
                  ),
                ),
              )),
        ),
      ),
    );
  }

  Widget silloginfo() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
                onPressed: () {},
                child: Text('이용약관', style: userText.CONTENTS_TEXT)),
            TextButton(
                onPressed: () {},
                child: Text('개인정보처리방침', style: userText.CONTENTS_TEXT)),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text('Contact us',
                              style: TextStyle(
                                //등록 : 컨텐츠 제목
                                color: Color(0xff979797),
                                fontWeight: FontWeight.bold, fontSize: 16,
                              )),
                        ),
                        Text(
                            'Email treering@sillog.me\n사업자등록번호 790-88-02017\n운영시간 10:00 ~ 18:00 점심 13:00 ~ 14:00',
                            style: userText.CONTENTS_TEXT),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                        'Copyright © Treering corp. All Rights Reserved',
                        style: userText.CONTENTS_TEXT),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '내 정 보'),
      body: Column(
        children: [
          Container(width: double.infinity, height: 0.5, color: UNSELECT_COLOR),
          profile(),
          logout(),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              color: Colors.white,
            ),
          ),
          silloginfo()
        ],
      ),
    );
  }
}
