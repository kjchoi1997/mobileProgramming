import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sillog/Registration/controller/file_add_list_controller.dart';
import 'package:sillog/FileManage/screens/add_file.dart';
import 'package:sillog/data/model/model.dart';
import 'package:sillog/utils/app_colors.dart';

class FileAddBtn extends StatelessWidget {
  const FileAddBtn({Key? key}) : super(key: key);

  void getFile() async {
    final fileController = Get.put(FileAddListController());
    FilePickerResult? result = await fileController.getFile();

    if (result != null) {
      await Get.to(FileDetailPage(),
          arguments: DocFile.preAdd(result.files.single.path!));
      // If user canceled the picker

    } else {
      Get.snackbar('실록 알림', '파일이 선택되지 않았어요 :(',
          snackPosition: SnackPosition.TOP);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          child: InkWell(
            onTap: () {
              getFile();
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
                '파일선택',
                style: TextStyle(color: Colors.black, fontSize: 14.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
