import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sillog/FileManage/screens/file_main.dart';
import 'package:sillog/Inquiry/screens/inq_main.dart';
import 'package:sillog/Registration/screens/reg_eventInfo.dart';
import 'package:sillog/home/components/slg_bottom_navigation_menu.dart';
import 'package:sillog/home/screens/user_profile.dart';
import 'package:sillog/utils/app_colors.dart';

class LandingPageController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}

class Home extends StatefulWidget {
  //메인 페이지
  Home();

  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final LandingPageController landingPageController =
        Get.put(LandingPageController());

    // safe area : 안드로이드나 아이폰 노치가 가리는 경우도 있을 수 잇는데, 기기별로 화면의 패딩을 만들어 주는 것을 의미함
    return Scaffold(
      bottomNavigationBar: SLGBottomNavigationMenu(),

      // An IndexedStack is a stack where only one component is shown at one time by its index.
      body: Obx(() => IndexedStack(
            index: landingPageController.tabIndex.value,
            children: [InqTag(), RegEventInfo(), FileList(), UserProfile()],
          )),
    );
  }
}
