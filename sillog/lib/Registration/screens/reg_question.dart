import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sillog/Registration/components/cancel_register_btn.dart';
import 'package:sillog/Registration/components/reg_addWidget.dart';
import 'package:sillog/Registration/components/req_questionWidget.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';
import 'package:sillog/Registration/data/model/reg_model.dart';
import 'package:sillog/Registration/screens/reg_tag.dart';
import 'package:sillog/utils/app_text_theme.dart';
import 'package:sillog/utils/const.dart';
import 'package:sillog/utils/utils.dart';
import 'package:sillog/widgets/appbar.dart';
import 'package:sillog/widgets/buttons.dart';
import 'package:sillog/widgets/snackbar.dart';

class RegQuestion extends StatefulWidget {
  @override
  _RegQuestionState createState() => _RegQuestionState();
}

class _RegQuestionState extends State<RegQuestion> {
  final sillogController = Get.find<SillogController>();
  final questionController = Get.find<QuestionController>();
  final quaformKey = GlobalKey<FormState>();

  List<Widget> _getQuestionList(questionLists) {
    List<Widget> qlist = <Widget>[];
    sillogController.qnaList = <QnaModel>[];
    for (var index = 0; questionLists.length > index; index++) {
      qlist.add(RegQuestionWidget(
          index: index + 1, question: questionLists[index], key: quaformKey));
      sillogController.qnaList.add(QnaModel(
        question: '${questionLists[index]}',
        answer: '',
      ));
    }
    // return RegQuestionWidget(
    //     index: index + 1,
    //     question: questionLists[index],
    //     key: quaformKey);

    return qlist;
  }

  @override
  Widget build(BuildContext context) {
    final questionLists = QnATemplate[questionController.categoriesName];
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.99),
        appBar: CustomAppBar(
          title: '등 록',
          step: 0.50,
          actions: [CancelRegisterButton()],
        ),
        body: Form(
          key: quaformKey,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Column(
                      children: [
                        Text(questionController.categoriesName,
                            style: RegText.INFO_TEXT),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '원하는 질문에만 답변을 작성해주세요!',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: _getQuestionList(questionLists),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RegAddWidget(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomButton(
            text: '작 성 완 료',
            onPressed: () async {
              if (quaformKey.currentState!.validate()) {
                quaformKey.currentState!.save();
              }
              if (sillogController.qnaList[0].answer != '') {
                Get.to(() => RegTag(),
                    arguments: 'template',
                    transition: Transition.rightToLeftWithFade);
              } else {
                SLG_Snackbar.alertSnackBar('한 줄 요약을 간단하게 해주세요 :)');
              }
            }));
  }
}
