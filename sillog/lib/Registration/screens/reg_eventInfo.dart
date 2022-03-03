import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sillog/Registration/components/reg_datePicker.dart';
import 'package:sillog/Registration/components/reg_inputTitle.dart';
import 'package:sillog/Registration/components/reg_typeAhead.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';
import 'package:sillog/Registration/screens/reg_memo.dart';
import 'package:sillog/utils/app_text_theme.dart';
import 'package:sillog/widgets/appbar.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:sillog/widgets/snackbar.dart';
import 'package:sillog/widgets/widgets.dart';

class RegEventInfo extends StatefulWidget {
  @override
  _RegEventInfoState createState() => _RegEventInfoState();
}

class _RegEventInfoState extends State<RegEventInfo> {
  late final textController;
  late final sillogController;

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController =
        KeyboardVisibilityController(); //키보드 활성화 감지
    keyboardVisibilityController.onChange.listen((bool visible) {});

    sillogController = Get.put(SillogController());
    sillogController.clearController();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Widget _datePicker() {
      return KeyboardVisibilityBuilder(builder: (context, visible) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: visible == true ? null : DatePicker(),
        );
      });
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(title: '등 록', step: 0.25),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text("실록의 이름과 날짜를 입력해주세요!", style: RegText.INFO_TEXT),
                ),
                InputTitle(controller: textController),
                _datePicker(),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomButton(
          text: '다   음',
          onPressed: () {
            //날짜 선택 안할 시, 현재 날짜 저장
            if (sillogController.dateList.isEmpty == true) {
              sillogController.dateList = [
                DateFormat('yyyy-MM-dd', 'en').format(DateTime.now()).toString()
              ];
            }

            //실록 제목 입력 완료 시, 다음 페이지 이동 가능
            if (textController.text != '') {
              sillogController.title = textController.text;
              print(sillogController.title);
              print(sillogController.dateList);
              Get.to(() => RegMemo(),
                  transition: Transition.rightToLeftWithFade);
            } else {
              SLG_Snackbar.alertSnackBar('앗, 실록 이름이 입력되지 않았어요 :(');
            }
          },
        ));
  }
}
