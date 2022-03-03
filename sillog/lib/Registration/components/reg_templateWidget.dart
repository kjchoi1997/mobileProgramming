import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sillog/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sillog/utils/app_text_theme.dart';

class RegTemplateWidget extends StatelessWidget {
  RegTemplateWidget({required this.text, required this.onTap, color}) {
    this.color = color ?? SLG_COLOR;
  }

  final String text;
  final VoidCallback onTap;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
              child: Ink(
                width: 130.w,
                // height: 200.w,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE0E0E0)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 100.0.w,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 15.0),
                            child: Image.asset('assets/image/logo.png'),
                          )),
                    ),
                    SizedBox(
                        height: 1.0,
                        child: Container(
                          color: Color(0xFFE0E0E0),
                          width: double.infinity,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(text,
                                  maxLines: 1, style: RegText.HEAD_TEXT),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: onTap),
        ],
      ),
    );
  }
}
