import 'package:flutter/material.dart';
import 'package:sillog/Registration/screens/reg_template.dart';
import 'package:sillog/utils/utils.dart';

class MemoWidget extends StatelessWidget {
  const MemoWidget({
    Key? key,
    required TextEditingController headTextController,
    required TextEditingController contentTextController,
  })  : _headTextController = headTextController,
        _contentTextController = contentTextController,
        super(key: key);

  final TextEditingController _headTextController;
  final TextEditingController _contentTextController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Container(
          height: 200,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.10),
                    blurRadius: 10.0,
                    spreadRadius: 3.0)
              ]),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    style: RegText.HEAD_TEXT,
                    controller: _headTextController,
                    decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: '큰제목',
                        hintStyle: RegText.HEAD_TEXT),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    maxLines: 5,
                    style: RegText.PRIMARY_TEXT,
                    controller: _contentTextController,
                    decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: '행사의 내용, 배운점, 느낌 등을 적어주세요',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFB9B9B9),
                            fontSize: 14)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            child: Container(
                                height: 40.0,
                                width: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25.0)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.10),
                                          blurRadius: 5.0,
                                          spreadRadius: 3.0)
                                    ]),
                                child: Image.asset('assets/image/logo.png')),
                            onTap: () => Get.to(() => RegTemplate(),
                                transition: Transition.fadeIn),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
