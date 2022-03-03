import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sillog/Registration/components/reg_addWidget.dart';
import 'package:sillog/Registration/components/req_questionWidget.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';
import 'package:sillog/Registration/screens/reg_tag.dart';
import 'package:sillog/utils/app_colors.dart';
import 'package:sillog/utils/app_text_theme.dart';
import 'package:sillog/widgets/appbar.dart';
import 'package:sillog/widgets/buttons.dart';

class RegCustom extends StatefulWidget {
  @override
  _RegCustomState createState() => _RegCustomState();
}

class _RegCustomState extends State<RegCustom> {
  final sillogController = Get.find<SillogController>();
  final customformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final customController = Get.put(CustomController());

    Widget _infoText() {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Text("템플릿 이름", style: RegText.INFO_TEXT),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text("원하시는 질문에 답변을 작성해주세요!", style: RegText.HEAD_TEXT),
          ),
          SizedBox(height: 20),
        ],
      );
    }

    Widget _customQuestion() {
      return Form(
        key: customformKey,
        child: Column(
          children: [
            RegQuestionWidget(
                index: 1, question: "이번 활동을 한 줄로 요약해주세요!", key: customformKey),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (int i = 0;
                      i < customController.custumQuestion.toInt();
                      i++)
                    Obx(
                      () => customController.custumQuestion.toInt() == 0
                          ? SizedBox(
                              width: 0,
                              height: 0,
                            )
                          : RegQuestionWidget(
                              index: i + 2,
                              question: "",
                              key: customformKey), //index 0부터 시작
                    )
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _addCustomQuestion() {
      return Padding(
        padding: const EdgeInsets.only(
            left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 3.0,
                    spreadRadius: 1.0)
              ]),
          child: ElevatedButton(
              child: Icon(
                Icons.add,
                color: LINE_COLOR,
              ),
              style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10),
                  ),
                  primary: Colors.white,
                  minimumSize: Size(400, 50)),
              onPressed: () async {
                customController.increment();
              }),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.99),
        appBar: CustomAppBar(title: '등 록', step: 0.50),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _infoText(),
              _customQuestion(),
              _addCustomQuestion(),
              RegAddWidget(),
            ],
          ),
        ),
        bottomNavigationBar: BottomButton(
            text: '작 성 완 료',
            onPressed: () async {
              if (customformKey.currentState!.validate()) {
                customformKey.currentState!.save();
                print(sillogController.qnaList);
              }
              Get.to(() => RegTag(),
                  transition: Transition.rightToLeftWithFade);
            }));
  }
}
