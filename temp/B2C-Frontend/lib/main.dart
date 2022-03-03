import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sillog/home/login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    KakaoContext.clientId = '05d9590a1a707bb0d968d8f5c3f462be';
    KakaoContext.javascriptClientId = "f640ae3663cb875c9a76d2091f972bb5";
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => GetMaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Sillog',
        theme: ThemeData(
          fontFamily: 'NotoSans',
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            textTheme: TextTheme(
              title: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            centerTitle: true,
            elevation: 15,
          ),
        ),
        home: KakaoLogin(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ko', 'KR'),
        ],
      ),
    );
  }
}
