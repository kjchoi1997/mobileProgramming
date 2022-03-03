import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sillog/home/screens/home.dart';

class SLGBottomNavigationMenu extends StatelessWidget {
  SLGBottomNavigationMenu({
    Key? key,
    this.ishome,
  }) : super(key: key);

  bool? ishome;
  final LandingPageController landingPageController =
      Get.put(LandingPageController());

  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedFontSize: 12,
          onTap: (index) {
            landingPageController.changeTabIndex(index);
            print(ishome);
            if (ishome == null) ishome = true;
            if (!ishome!) Get.offAll(() => Home());
          },
          currentIndex: landingPageController.tabIndex.value,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black38,
          selectedItemColor: Colors.black,
          unselectedLabelStyle: unselectedLabelStyle,
          selectedLabelStyle: selectedLabelStyle,
          items: [
            BottomNavigationBarItem(
              icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset('assets/image/nav_icon/home.png')),
              label: 'Home',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset('assets/image/nav_icon/new.png')),
              label: 'New',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset('assets/image/nav_icon/file.png')),
              label: 'File',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset('assets/image/nav_icon/my.png')),
              label: 'My',
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
