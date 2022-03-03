import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// TODO : 빌드 이전에 폰트 선택하기
const String fontNameDefault = 'SpoqaHanSansNeo';
// const String fontNameDefault = 'Roboto';

abstract class ThemeText {
  // 기본 텍스트
  static const TextStyle normal = TextStyle(
    color: Colors.black,
    fontFamily: fontNameDefault,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  // 제목 : Head 1
  static const TextStyle h1 = TextStyle(
    color: Colors.black,
    fontFamily: fontNameDefault,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  // 소제목 : Head 2
  static const TextStyle h2 = TextStyle(
    color: Colors.black,
    fontFamily: fontNameDefault,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  // 단락 : Paragraph 1
  static const TextStyle p1 = TextStyle(
    color: Colors.black,
    fontFamily: fontNameDefault,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  // 설명/날짜
  static const TextStyle info = TextStyle(
    color: Colors.black,
    fontFamily: fontNameDefault,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}

abstract class ThemeText_white {
  // 기본 텍스트
  static const TextStyle normal = TextStyle(
    color: Colors.white,
    fontFamily: fontNameDefault,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  // 제목 : Head 1
  static const TextStyle h1 = TextStyle(
    color: Colors.white,
    fontFamily: fontNameDefault,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  // 소제목 : Head 2
  static const TextStyle h2 = TextStyle(
    color: Colors.white,
    fontFamily: fontNameDefault,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  // 단락 : Paragraph 1
  static const TextStyle p1 = TextStyle(
    color: Colors.white,
    fontFamily: fontNameDefault,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  // 설명/날짜
  static const TextStyle info = TextStyle(
    color: Colors.white,
    fontFamily: fontNameDefault,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}

abstract class ButtonText {
  static const TextStyle bottomButton =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  static TextStyle pickerButton =
      TextStyle(color: Colors.black, fontSize: 14.sp);
}

abstract class FileManageText {
  static const TextStyle INDEX_TEXT = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
}

abstract class RegText {
  static const TextStyle INFO_TEXT =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold); //등록 : 설명

  static const TextStyle HEAD_TEXT = TextStyle(
    //등록 : 컨텐츠 제목
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const TextStyle CONTENTS_TEXT = TextStyle(
    //등록 : 리스트
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );

  static const TextStyle PRIMARY_TEXT = TextStyle(
    //등록 : 기본 텍스트
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
}

abstract class userText {
  //유저 페이지
  static const TextStyle INFO_TEXT = TextStyle(
    //프로필 : 프로필 정보
    color: Color(0xff979797),
    fontSize: 14,
  );

  static const TextStyle CONTENTS_TEXT = TextStyle(
    //프로필 : 컨텐츠 내용
    color: Color(0xff979797),
    fontSize: 12,
  );
}
