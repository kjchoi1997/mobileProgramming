import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sillog/data/provider/database.dart';
import 'package:sillog/data/provider/filedb.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sillog/data/provider/tagdb.dart';
import 'home/screens/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final db = Database();
  GetIt.instance.registerSingleton<UserFileDao>(UserFileDao(db));
  GetIt.instance.registerSingleton<MyTagDao>(MyTagDao(db));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF163C6B), // navigation bar color
      // statusBarColor: Color(0xFF163C6B), // status bar color
    ));
    KakaoContext.clientId = '05d9590a1a707bb0d968d8f5c3f462be';
    KakaoContext.javascriptClientId = "f640ae3663cb875c9a76d2091f972bb5";
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => GetMaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Sillog',
        theme: ThemeData(
          fontFamily: 'NotoSans',
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            centerTitle: true,
            elevation: 15,
          ),
        ),
        home: SplashScreen(),
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
