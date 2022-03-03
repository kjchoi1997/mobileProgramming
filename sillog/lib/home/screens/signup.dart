import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sillog/home/screens/tag_select.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회 원 가 입', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF163C6B),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_next),
            color: Colors.white,
            onPressed: () =>
                Get.to(TagSelect(), transition: Transition.rightToLeftWithFade),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 0.5.sh),
          Padding(
            padding: const EdgeInsets.fromLTRB(35.0, 10.0, 35.0, 10.0),
            child: ElevatedButton(
                child: Text(
                  "카 카 오 톡",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 47.h),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    primary: Color(0xFF163C6B)),
                onPressed: () {}),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35.0, 10.0, 35.0, 10.0),
            child: ElevatedButton(
                child: Text(
                  "페 이 스 북",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 47.h),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    primary: Color(0xFF163C6B)),
                onPressed: () {}),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35.0, 10.0, 35.0, 10.0),
            child: ElevatedButton(
                child: Text(
                  "구          글",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 47.h),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    primary: Color(0xFF163C6B)),
                onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
