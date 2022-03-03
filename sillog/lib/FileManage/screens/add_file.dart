import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:sillog/FileManage/components/file_preview.dart';
import 'package:sillog/FileManage/controller/file_controller.dart';
import 'package:sillog/Registration/controller/file_add_list_controller.dart';

import 'package:sillog/utils/utils.dart';
import 'package:sillog/widgets/widgets.dart' as widgets;
import 'package:sillog/data/model/model.dart';

class FileDetailPage extends StatefulWidget {
  const FileDetailPage({Key? key}) : super(key: key);

  @override
  _FileDetailPageState createState() => _FileDetailPageState();
}

class _FileDetailPageState extends State<FileDetailPage> {
  TextEditingController? titleController;

  late final controller;

  late DocFile _originFile;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    initFile();
  }

  void initFile() {
    titleController = TextEditingController();
    controller = Get.put(FileAddListController());

    _originFile = Get.arguments;
    _selectedIndex = FileCategories.length - 1;
    titleController!.text = _originFile.name;

    for (int i = 0; i < FileCategories.length; i++)
      if (FileCategories[i]['title'] == _originFile.category) {
        _selectedIndex = i;
        break;
      }

    // if (_originFile.extension == null) Get.back();
  }

  Widget renderPreviewFile() {
    return Container(
      height: 130,
      width: 130,
      child: FilePreview(extension: _originFile.extension),
      alignment: Alignment.center,
    );
  }

  Widget renderTitleInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 40, 16, 40),
      child: Column(
        children: [
          Container(
            child: Text(
              "문서명",
              textAlign: TextAlign.left,
              style: FileManageText.INDEX_TEXT,
            ),
            alignment: Alignment.bottomLeft,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: CupertinoTextField(
              controller: titleController,
              clearButtonMode: OverlayVisibilityMode.editing,
            ),
            height: 45,
          ),
        ],
      ),
    );
  }

  Widget renderTagList() {
    List<Widget> chips = [];
    for (int i = 0; i < FileCategories.length; i++) {
      bool _isChecked = (_selectedIndex == i);

      Widget choiceChip = widgets.SLG_Chips.getFileChip(
        isChecked: _isChecked,
        label: FileCategories[i]['title'],
        onSelected: (bool selected) {
          setState(() {
            _selectedIndex = i;
          });
        },
      );

      chips.add(choiceChip);
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 40, 16, 40),
      child: Column(
        children: [
          Container(
            child: Text(
              "카테고리",
              textAlign: TextAlign.left,
              style: FileManageText.INDEX_TEXT,
            ),
            alignment: Alignment.topLeft,
          ),
          Wrap(
            alignment: WrapAlignment.start,
            children: chips,
            spacing: 15,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('파일 정보 입력'),
          backgroundColor: APP_BG_COLOR,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 57,
              ),
              renderPreviewFile(),
              renderTitleInput(),
              renderTagList(),
            ],
          ),
        ),
        bottomNavigationBar: widgets.BottomButton(
            onPressed: () async {
              FileController.updateFileInst(
                _originFile,
                titleController!.text,
                FileCategories[_selectedIndex]['title'],
              );
              controller.addFile(_originFile);
              Get.back(result: _originFile);
            },
            text: '완   료'));
  }
}
