import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sillog/Inquiry/controller/tag_list_controller.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';
import 'package:sillog/Registration/data/model/reg_model.dart';
import 'package:sillog/Registration/screens/reg_memo.dart';
import 'package:sillog/Registration/screens/reg_tag.dart';
import 'package:sillog/utils/app_colors.dart';
import 'package:sillog/widgets/dialog.dart';

class InqTagChip extends StatelessWidget {
  InqTagChip(
      {Key? key, required this.tagModel, this.isChecked = false, this.onTap})
      : super(key: key);
  bool isChecked;

  final TagModel tagModel;
  var onTap;

  @override
  Widget build(BuildContext context) {
    late final tagListController = Get.find<TagListController>();
    late final tagController = Get.find<TagController>();
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          child: InkWell(
            onLongPress: () => {
              SLG_Dialog.defaultDialog(
                title: '태그 삭제',
                middleText: '해당 태그를 삭제하시겠습니까',
                textConfirm: '삭제',
                onConfirm: () async {
                  await tagController.removeTag(
                      tagModel.category, tagModel.tagName);
                  Get.back();
                },
              ),
            },
            onTap: onTap ??
                () {
                  if (this.isChecked == true) {
                    tagListController.deleteTag(tagModel);
                  } else {
                    tagListController.addTag(tagModel);
                  }
                },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              decoration: BoxDecoration(
                color: isChecked == true ? SLG_COLOR : Colors.white,
                border: isChecked == true
                    ? Border.all(color: Colors.white)
                    : Border.all(color: SLG_COLOR),
                borderRadius: new BorderRadius.circular(50.0),
              ),
              child: Text(
                '# ${tagModel.tagName}',
                style: TextStyle(
                    color: isChecked == true ? Colors.white : Colors.black,
                    fontSize: 14.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EditTagChip extends StatelessWidget {
  EditTagChip(
      {Key? key,
      required this.tagModel,
      this.isChecked = false,
      required this.onTap})
      : super(key: key);
  bool isChecked;

  final TagModel tagModel;
  var onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 5,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            decoration: BoxDecoration(
              color: isChecked == true ? SLG_COLOR : Colors.white,
              border: Border.all(color: SLG_COLOR),
              borderRadius: new BorderRadius.circular(50.0),
            ),
            child: Text(
              '# ${tagModel.tagName}',
              style: TextStyle(
                  color: isChecked == true ? Colors.white : Colors.black,
                  fontSize: 14.0),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Get.find<TagController>().unselectTag(this.tagModel);
          },
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.cancel_rounded,
              color: Color(0xffBCBCBC),
            ),
          ),
        )
      ],
    );
  }
}

class AddChip extends StatelessWidget {
  const AddChip({Key? key, this.onTap}) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    TextEditingController? _tagAddController = TextEditingController();
    final tagController = Get.find<TagController>();

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          child: InkWell(
            onLongPress: () => {print('+')},
            onTap: onTap ??
                () {
                  Get.defaultDialog(
                      title: '사용자 태그 추가',
                      titleStyle:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                      content: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xFFF6F6F6),
                              border: Border.all(color: SLG_COLOR, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              )),
                          child: TextField(
                            controller: _tagAddController,
                          )),
                      confirm: MaterialButton(
                          onPressed: () async {
                            await tagController.addTag(
                                '사용자', _tagAddController.text);
                            _tagAddController.text = '';
                            Get.back();
                          },
                          child: Text('추가')),
                      cancel: MaterialButton(
                          onPressed: () => Get.back(), child: Text('취소')));
                },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: SLG_COLOR),
                borderRadius: new BorderRadius.circular(50.0),
              ),
              child: Text(
                '+',
                style: TextStyle(color: Colors.black, fontSize: 14.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TagChip extends StatelessWidget {
  //버튼 칩스
  TagChip(
      {index,
      add,
      required this.tagModel,
      required this.onTap,
      this.onLongPress,
      this.isChecked}) {
    this.index = index ?? -1;
    this.add = add ?? '';
  }

  int? index;
  String? add;
  final TagModel tagModel;
  bool? isChecked = false;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  TextEditingController? _tagAddController = TextEditingController();
  final tagController = Get.find<TagController>();

  Widget defalut_chip_widget() {
    //기본 태그칩 위젯, 삭제 기능 x
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress ?? () {},
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              decoration: BoxDecoration(
                color: isChecked == true ? SLG_COLOR : Colors.white,
                border: Border.all(color: SLG_COLOR),
                borderRadius: new BorderRadius.circular(50.0),
              ),
              child: Text(
                '# ${tagModel.tagName}',
                style: TextStyle(
                    color: isChecked == true ? Colors.white : Colors.black,
                    fontSize: 14.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget custom_chip_widget() {
    //커스텀 태그칩 위젯, 삭제 기능 o
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          child: InkWell(
            onLongPress: () => {
              SLG_Dialog.defaultDialog(
                title: '태그 삭제',
                middleText: '해당 태그를 삭제하시겠습니까',
                textConfirm: '삭제',
                onConfirm: () async {
                  await tagController.removeTag(
                      tagModel.category, tagModel.tagName);
                  Get.back();
                },
              ),
            },
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              decoration: BoxDecoration(
                color: isChecked == true ? SLG_COLOR : Colors.white,
                border: Border.all(color: SLG_COLOR),
                borderRadius: new BorderRadius.circular(50.0),
              ),
              child: Text(
                '# ${tagModel.tagName}',
                style: TextStyle(
                    color: isChecked == true ? Colors.white : Colors.black,
                    fontSize: 14.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget add_chip_widget() {
    //태그 추가 위젯
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          child: InkWell(
            onLongPress: () => {print('+')},
            onTap: () {
              Get.defaultDialog(
                  title: '사용자 태그 추가',
                  titleStyle:
                      TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  content: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xFFF6F6F6),
                          border: Border.all(color: SLG_COLOR, width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          )),
                      child: TextField(
                        controller: _tagAddController,
                      )),
                  confirm: MaterialButton(
                      onPressed: () async {
                        await tagController.addTag(
                            tagModel.category, _tagAddController!.text);
                        Get.back();
                      },
                      child: Text('추가')),
                  cancel: MaterialButton(
                      onPressed: () => Get.back(), child: Text('취소')));
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: SLG_COLOR),
                borderRadius: new BorderRadius.circular(50.0),
              ),
              child: Text(
                '+',
                style: TextStyle(color: Colors.black, fontSize: 14.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return add == '사용자'
        ? index == 0
            ? Wrap(
                children: [add_chip_widget(), custom_chip_widget()],
              )
            : custom_chip_widget()
        : defalut_chip_widget();
  }
}

class TagChipX extends StatelessWidget {
  //x 아이콘 버튼 칩스
  TagChipX(
      {required this.tagModel,
      required this.icon,
      required this.isChecked,
      required this.onTap});

  final TagModel tagModel;
  final bool isChecked;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 2.5,
            horizontal: 2.5,
          ),
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              decoration: BoxDecoration(
                color: isChecked == true ? SLG_COLOR : Colors.white,
                border: Border.all(color: SLG_COLOR),
                borderRadius: new BorderRadius.circular(50.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '# ${tagModel.tagName}',
                    style: TextStyle(
                        color: isChecked == true ? Colors.white : Colors.black,
                        fontSize: 14.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Icon(this.icon, color: Colors.white, size: 16),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
