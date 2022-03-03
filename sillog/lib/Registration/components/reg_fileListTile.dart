import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sillog/FileManage/screens/add_file.dart';
import 'package:sillog/Registration/controller/file_add_list_controller.dart';
import 'package:sillog/data/model/model.dart';
import 'package:sillog/widgets/dialog.dart';

class FileListTile extends StatelessWidget {
  FileListTile(this.file);

  final DocFile file;
  final fileController = Get.put(FileAddListController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListTile(
          leading: Icon(Icons.file_copy),
          title: Text(file.name),
          trailing: InkWell(
            child: Icon(Icons.cancel),
            onTap: () {
              SLG_Dialog.defaultDialog(
                title: '첨부파일 삭제',
                middleText: '${file.name} 을 삭제하시겠습니까',
                textConfirm: '삭제',
                onConfirm: () {
                  fileController.deleteFile(file);
                  Get.back();
                },
              );
            },
          ),
        ),
      ),
      onTap: () async {
        await Get.to(FileDetailPage(), arguments: file);
      },
    );
  }
}
