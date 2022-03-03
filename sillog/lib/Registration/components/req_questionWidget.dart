import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';
import 'package:sillog/Registration/data/model/reg_model.dart';
import 'package:sillog/utils/app_text_theme.dart';

class RegQuestionWidget extends StatefulWidget {
  RegQuestionWidget({required this.index, question, key}) {
    this.question = question ?? '';
  }

  int index;
  String? question;
  GlobalKey? key;

  @override
  _RegQuestionWidgetState createState() => _RegQuestionWidgetState();
}

class _RegQuestionWidgetState extends State<RegQuestionWidget> {
  final sillogController = Get.find<SillogController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadowColor: Colors.black38,
          child: ExpansionTile(
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            title: Row(
              children: [
                Text(
                  widget.index == 1
                      ? '★.  '
                      : 'Q${(widget.index - 1).toString()}. ',
                  style: RegText.HEAD_TEXT,
                ),
                Expanded(
                  child: Text(
                    '${widget.question}',
                    style: RegText.PRIMARY_TEXT,
                    softWrap: true,
                  ),
                )
              ],
            ),
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15),
                child: TextFormField(
                  onSaved: (String? value) {
                    sillogController.qnaList[widget.index - 1] = (QnaModel(
                        question: '${widget.question.toString()}',
                        answer: value?.toString() ?? ''));
                  },
                  maxLines: widget.index == 1 ? 1 : 7,
                  style: RegText.PRIMARY_TEXT,
                  decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: '답변을 작성해주세요.',
                      hintStyle:
                          TextStyle(color: Color(0xFFB9B9B9), fontSize: 12)),
                ),
              ),
            ],
          ),
        ));
  }
}
