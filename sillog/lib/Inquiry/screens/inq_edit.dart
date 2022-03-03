import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sillog/Inquiry/data/model/inq_model.dart';
import 'package:sillog/Inquiry/screens/inq_edit_tag.dart';
import 'package:sillog/Registration/components/reg_addWidget.dart';
import 'package:sillog/Registration/components/reg_datePicker.dart';
import 'package:sillog/Registration/components/reg_inputTitle.dart';
import 'package:sillog/Registration/components/reg_memoWidget.dart';
import 'package:sillog/Registration/components/reg_selectedImageList.dart';
import 'package:sillog/Registration/controller/image_add_controller.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';
import 'package:sillog/Registration/data/model/model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sillog/home/screens/home.dart';
import 'package:sillog/utils/utils.dart';
import 'package:sillog/widgets/appbar.dart';
import 'package:sillog/widgets/buttons.dart';
import 'package:sillog/widgets/tagChips.dart';

//리팩토링
var sillogColor = Color(0xFF163C6B);
var backgroundColor = Color(0xFFC4C4C4);
var buttonColor = Color(0xFF163C6B);

class InqEdit extends StatefulWidget {
  @override
  _InqEditState createState() => _InqEditState();
}

class _InqEditState extends State<InqEdit> {
  final picker = ImagePicker();

  late final DetailModel sillog;
  late final SillogController sillogController;
  late final TagController tagController;
  // QuestionController imageController = new QuestionController();
  // QuestionController2 fileController = new QuestionController2();
  late final TextEditingController _titleController;
  late final TextEditingController _headTextController;
  late final TextEditingController _contentTextController;

  // final userController = Get.find<UserController>();
  // final sillogController = Get.find<SillogController>();

  @override
  initState() {
    super.initState();
    sillog = Get.arguments;
    sillogController = Get.find<SillogController>();
    sillogController.id = sillog.id;
    tagController = Get.find<TagController>();
    // Get.arguments => Detail Model과 함께 이동해야 함

    // 태그 초기화
    tagController.selectedtags = sillog.tagList.obs;
    sillogController.updateWithSillog(sillog);
    Get.find<SillogController>().tagList =
        tagController.selectedtags.map((e) => e.toJson()).toList();

    // controller 초기화
    _titleController = TextEditingController();
    _headTextController = TextEditingController();
    _contentTextController = TextEditingController();

    // textField 초기화
    _titleController.text = sillog.title;
    _headTextController.text = sillog.memo.head;
    _contentTextController.text = sillog.memo.body;

    // 파일 업로드 초기화

    // 이미지 초기화
    Get.put(ImageListController()).selectedImageList = sillog.imageList;
    Get.find<SillogController>().imageList = sillog.imageList;
  }

  Widget _getDate(dateList) {
    return dateList.length == 1
        ? Text(
            DateFormat('yyyy.MM.dd(E)', 'kor')
                .format(DateTime.parse(sillog.dateList[0])),
            style: ThemeText.p1)
        : Text(
            '${DateFormat('yy.MM.dd(E)', 'kor').format(DateTime.parse(sillog.dateList[0]))} ~ ${DateFormat('yy.MM.dd(E)', 'kor').format(DateTime.parse(sillog.dateList[1]))}',
            style: ThemeText.p1,
          );
  }

  Widget _sillogInfo(context) {
    return Container(
        width: 1.sw,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _getDate(sillogController.dateList),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.defaultDialog(
                              title: '날짜 수정',
                              titlePadding: EdgeInsets.symmetric(vertical: 15),
                              radius: 10,
                              titleStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: SLG_COLOR),
                              backgroundColor: Colors.white,
                              content:
                                  SizedBox(height: 330, child: DatePicker()),
                              confirm: TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  '확 인',
                                  style: TextStyle(
                                    color: SLG_COLOR,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Icon(Icons.edit),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        sillog.title,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              _tagWidget(tagController.selectedtags),
            ],
          ),
        ));
  }

  Widget _tagWidget(RxList<TagModel> tagList) {
    //상단 태그 리스트
    return Obx(() => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Wrap(
              alignment: WrapAlignment.start,
              children: tagList
                  .map((tagModel) => EditTagChip(
                        key: ValueKey(tagModel),
                        tagModel: tagModel,
                        isChecked: false,
                        onTap: () {},
                      ))
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: AddChip(
                onTap: () => Get.to(() => EditTag()),
              ),
            )
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.99),
      appBar: CustomAppBar(title: '수정', leading: true),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // * 제목 수정
                // InputTitle(controller: _titleController),
                _sillogInfo(context),

                SizedBox(
                  height: 10.h,
                ),

                // * 본문 수정
                MemoWidget(
                  headTextController: _headTextController,
                  contentTextController: _contentTextController,
                ),

                // TODO: QNA
                SizedBox(
                  height: 15.h,
                ),

                // * 파일 및 사진 등록
                SelectedImageList(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomButton(
          text: "수  정  완  료",
          onPressed: () async {
            sillogController.title = _titleController.text;

            // 본문 수정
            sillogController.memoHead = _headTextController.text;
            sillogController.memoContent = _contentTextController.text;

            // qna 수정

            // 태그 수정
            await sillogController.sillogPatchToServer();

            Get.offAll(Home());
          }),
    );
  }
}
