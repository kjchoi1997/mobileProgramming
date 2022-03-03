import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';
import 'package:sillog/home/screens/home.dart';
import 'package:sillog/widgets/buttons.dart';

class RegComplete extends StatelessWidget {
  final count = Get.find<CountController>().count + 1;

  Widget _complete() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
                child: Text(
              '기록 완료!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ))),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            child: Image.asset('assets/image/logo.png'),
            height: 130.h,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: Column(
              children: [
                Text("지금까지",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, height: 2),
                    textAlign: TextAlign.center),
                Text("$count개",
                    style: TextStyle(
                        fontSize: 27, fontWeight: FontWeight.bold, height: 2),
                    textAlign: TextAlign.center),
                Text("실록을 기록했어요👍",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, height: 2),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100.0,
              ),
              _complete(),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomButton(
            text: '확   인',
            onPressed: () {
              Get.find<LandingPageController>().changeTabIndex(0);
              Get.find<CountController>().count = count; //작성 포함
              Get.offAll(() => Home(),
                  transition: Transition.rightToLeftWithFade);
            }));
  }
}
