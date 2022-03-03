import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sillog/FileManage/controller/file_controller.dart';
import 'package:sillog/FileManage/controller/file_list_controller.dart';
import 'package:sillog/FileManage/screens/add_file.dart';
import 'package:sillog/data/model/model.dart';
import 'package:sillog/utils/utils.dart';

import 'package:path/path.dart' as p;
import 'package:sillog/widgets/dialog.dart';

class FileDeleteButton extends StatelessWidget {
  const FileDeleteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FileListController());

    return FloatingActionButton(
        backgroundColor: SLG_COLOR,
        child: Icon(Icons.delete),
        onPressed: () => SLG_Dialog.checkDialog(
              middleText: '파일들을 정말로 삭제하실 건가요??',
              title: '파일 삭제',
              onPressed: () async {
                var dirPath = await getApplicationDocumentsDirectory();
                String appPath = dirPath.path;
                try {
                  controller.selectedFileList.forEach((key, value) {
                    FileController.deleteFile(
                        value.id, p.join(appPath, value.name));
                  });

                  controller.changeMode();
                } catch (e) {}
              },
            ));
  }
}

class FileAddButton extends StatelessWidget {
  FileAddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 0.0,
        backgroundColor: SLG_COLOR,
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();
          if (result != null) {
            // File file = File(result.files.single.path!);
            var docFile = await Get.to(FileDetailPage(),
                arguments: DocFile.preAdd(result.files.single.path!));
            try {
              FileController.updateDB(docFile);
              FileController.copyFileToAppdir(docFile);
            } catch (e) {}
          } else {
            // User canceled the picker
            Get.snackbar('실록 알림', '파일이 선택되지 않았어요 :(',
                snackPosition: SnackPosition.TOP);
          }
        }
        // onPressed: () async {
        //   showModalBottomSheet(
        //     context: context,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(10.0),
        //     ),
        //     builder: (context) => SingleChildScrollView(
        //       child: SafeArea(
        //         child: SizedBox(
        //           child: Column(
        //             children: [
        //               Padding(
        //                 padding: const EdgeInsets.symmetric(vertical: 10),
        //                 child: Container(
        //                     width: context.width / 3,
        //                     height: 5,
        //                     decoration: BoxDecoration(
        //                         color: Colors.black,
        //                         borderRadius: BorderRadius.circular(10))),
        //               ),
        //               AddSelectListCard(
        //                 text: '파일',
        //                 onTap: () async {
        //                   Navigator.pop(context);

        //                   FilePickerResult? result =
        //                       await FilePicker.platform.pickFiles();
        //                   if (result != null) {
        //                     // File file = File(result.files.single.path!);
        //                     var docFile = await Get.to(FileDetailPage(),
        //                         arguments:
        //                             DocFile.preAdd(result.files.single.path!));

        //                     FileController.updateDB(docFile);
        //                     FileController.copyFileToAppdir(docFile);
        //                   } else {
        //                     // User canceled the picker
        //                     Get.snackbar('실록 알림', '파일이 선택되지 않았어요 :(',
        //                         snackPosition: SnackPosition.TOP);
        //                   }
        //                 },
        //                 icon: Icon(Icons.file_copy),
        //               ),
        //               AddSelectListCard(
        //                 text: '사진',
        //                 onTap: () {},
        //                 icon: Icon(Icons.photo),
        //               ),
        //               Padding(
        //                 padding: const EdgeInsets.symmetric(
        //                     horizontal: 25, vertical: 5),
        //                 child: Card(
        //                     elevation: 0.0,
        //                     child: ListTile(
        //                         onTap: () => Get.back(),
        //                         title: Center(
        //                           child: Text('취소',
        //                               style: TextStyle(color: Colors.red)),
        //                         ))),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   );
        // },
        );
  }
}

class AddSelectListCard extends StatelessWidget {
  const AddSelectListCard({Key? key, this.text, this.onTap, required this.icon})
      : super(key: key);

  final text;
  final onTap;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Card(
          elevation: 0.0,
          child: ListTile(
            title: Text(text),
            trailing: Icon(Icons.photo),
            tileColor: Colors.white,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
