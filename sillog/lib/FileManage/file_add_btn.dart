import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:sillog/utils/utils.dart';
import 'package:sillog/widgets/widgets.dart' as widgets;
import 'package:sillog/data/model/model.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sillog/FileManage/screens/add_file.dart';
import 'package:sillog/Registration/controller/file_add_list_controller.dart';
import 'package:sillog/Registration/controller/image_add_controller.dart';
import 'package:file_picker/file_picker.dart';

class FileAddPage extends StatefulWidget {
  const FileAddPage({Key? key}) : super(key: key);

  @override
  _FileAddPageState createState() => _FileAddPageState();
}

class _FileAddPageState extends State<FileAddPage> {
  final fileController = Get.put(FileAddListController());
  final imageController = Get.put(ImageListController());

  void getFile() async {
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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10.w,
                ),
                widgets.PickerButton(
                  text: '스캔',
                  onPressed: () async {
                    await imageController.getImage(ImageSource.gallery);
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    color: SLG_COLOR,
                  ),
                ),
                widgets.PickerButton(
                  text: '기존파일',
                  onPressed: () async {
                    getFile();
                  },
                ),
                // SizedBox(
                //   height: 200,
                //   child: Obx(() => ListView.separated(
                //         itemCount: fileController.selectedFiles.length,
                //         itemBuilder: (BuildContext context, int index) {
                //           return FileListTile(
                //               fileController.selectedFiles[index]);
                //         },
                //         separatorBuilder: (BuildContext context, int index) {
                //           return Divider();
                //         },
                //       )),
                // ),
                // SizedBox(
                //   height: 200,
                //   child: Obx(
                //     () => ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       itemCount: imageController.selectedImageList.length,
                //       itemBuilder: (BuildContext context, int index) {
                //         return GalleryItemThumbnail(
                //             galleryItem:
                //                 imageController.selectedImageList[index],
                //             onTap: () {
                //               Get.to(() => GalleryPhotoViewWrapper(
                //                     galleryItems:
                //                         imageController.selectedImageList,
                //                     initialIndex: index,
                //                   ));
                //             });
                //         // return ImageListTile(
                //         //     imageController.selectedImageList[index]);
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class FileListTile extends StatelessWidget {
//   FileListTile(this.file);

//   final DocFile file;
//   final fileController = Get.put(FileAddListController());

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: ListTile(
//             leading: Icon(Icons.file_copy),
//             title: Text(file.name),
//             trailing: InkWell(
//               child: Icon(Icons.cancel),
//               onTap: () {
//                 SLG_Dialog.defaultDialog(
//                   title: '첨부파일 삭제',
//                   middleText: '${file.name} 을 삭제하시겠습니까',
//                   textConfirm: '삭제',
//                   onConfirm: () {
//                     fileController.deleteFile(file);
//                     Get.back();
//                   },
//                 );
//               },
//             )),
//       ),
//       onTap: () async {
//         await Get.to(FileDetailPage(), arguments: file);
//       },
//     );
//   }
// }

// class ImageListTile extends StatelessWidget {
//   ImageListTile(this.file);

//   final file;
//   final iamgeController = Get.put(ImageListController());

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.topRight,
//       children: [
//         InkWell(
//           child: Container(
//             child: Image.file(
//               file.nameWithExt,
//               width: 60.w,
//               height: 60.h,
//               fit: BoxFit.fill,
//             ),
//           ),
//           onTap: () {},
//         ),
//         InkWell(
//           child: Opacity(
//             opacity: 0.3,
//             child: Container(
//               color: Colors.white,
//               child: Icon(
//                 Icons.close_outlined,
//                 size: 20.w,
//               ),
//             ),
//           ),
//           onTap: () {
//             SLG_Dialog.defaultDialog(
//               title: '첨부파일 삭제',
//               middleText: '${file.name} 을 삭제하시겠습니까',
//               textConfirm: '삭제',
//               onConfirm: () {
//                 iamgeController.deleteFile(file);
//                 Get.back();
//               },
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
