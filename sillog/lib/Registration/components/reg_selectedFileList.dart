import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sillog/Registration/controller/file_add_list_controller.dart';
import 'package:sillog/Registration/components/reg_FileListTile.dart';
import 'package:sillog/Registration/components/reg_fileAddBtn.dart';
import 'package:sillog/Registration/components/reg_iconWidget.dart';
import 'package:sillog/utils/utils.dart';

class SelectedFileList extends StatelessWidget {
  const SelectedFileList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fileAddController = Get.put(FileAddListController());

    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            IconWidget(icon: Icons.folder_outlined),
            Text('증명서 / 상장', style: RegText.HEAD_TEXT),
            SizedBox(
              width: 30,
            ),
            FileAddBtn(),
          ],
        ),
        SizedBox(
          height: 200,
          child: Obx(() => ListView.separated(
                itemCount: fileAddController.selectedFiles.length,
                itemBuilder: (BuildContext context, int index) {
                  return FileListTile(fileAddController.selectedFiles[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              )),
        ),
        // Obx(
        //   () => SingleChildScrollView(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: <Widget>[
        //         for (var i = 0; i < _fileList.length; i++)
        //           Obx(
        //             () => _fileList[i] == ''
        //                 ? SizedBox(
        //                     width: 0,
        //                     height: 0,
        //                   )
        //                 : SelectedFileList(
        //                     image: Image.file(File(_fileList[i])),
        //                     title: basename(_fileList[i]),
        //                     filename: _fileList[i]),
        //           ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
