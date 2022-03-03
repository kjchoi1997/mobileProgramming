import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:sillog/Registration/components/cancel_register_btn.dart';
import 'package:sillog/Registration/components/reg_addWidget.dart';
import 'package:sillog/Registration/components/reg_memoWidget.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';
import 'package:sillog/Registration/screens/reg_tag.dart';
import 'package:sillog/utils/utils.dart';
import 'package:sillog/widgets/appbar.dart';
import 'package:sillog/widgets/snackbar.dart';
import 'package:sillog/widgets/widgets.dart';

// 파일경로: /data/data/com.apk_test.sillog/app_flutter
// RxList<String> _imageList = Get.find<SillogController>().imageList;
// RxList<String> _fileList = Get.find<SillogController>().fileList;

class RegMemo extends StatefulWidget {
  const RegMemo({key}) : super(key: key);

  @override
  _RegMemoState createState() => _RegMemoState();
}

class _RegMemoState extends State<RegMemo> {
  late final TextEditingController _headTextController;
  late final TextEditingController _contentTextController;
  final sillogController = Get.find<SillogController>();

  @override
  initState() {
    super.initState();

    _headTextController = TextEditingController();
    _contentTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // _headTextController.addListener(() {
    //   setState(() {});
    // });
    // _contentTextController.addListener(() {
    //   setState(() {});
    // });

    return Scaffold(
        appBar: CustomAppBar(
          title: '등 록',
          step: 0.50,
          actions: [CancelRegisterButton()],
        ),
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text("간단하게 메모해주세요!", style: RegText.INFO_TEXT),
                ),
                MemoWidget(
                  headTextController: _headTextController,
                  contentTextController: _contentTextController,
                ),
                RegAddWidget(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomButton(
            text: '작 성 완 료',
            onPressed: () async {
              if (_headTextController.text != '' &&
                  _contentTextController.text != '') {
                sillogController.memoHead = _headTextController.text;
                sillogController.memoContent = _contentTextController.text;

                print(sillogController.memo);
                Get.to(() => RegTag(),
                    arguments: 'memo',
                    transition: Transition.rightToLeftWithFade);
              } else {
                SLG_Snackbar.alertSnackBar('큰 제목, 내용 모두 입력해 주세요 :)');
              }
            }));
  }
}
