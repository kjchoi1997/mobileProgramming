// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:sillog/Registration/controller/reg_controller.dart';
// import 'package:sillog/utils/app_colors.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sillog/utils/app_text_theme.dart';

// RxList<String> _imageList =
//     Get.find<SillogController>().imageList; //삭제 기능 추가 필요
// RxList<String> _fileList = Get.find<SillogController>().fileList;

// // class SelectedImageList extends StatelessWidget {
// //   SelectedImageList({required this.image, required this.filename});

// //   final Image image;
// //   String? filename;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.all(10.0),
// //       child: Container(
// //         height: 60,
// //         width: 60,
// //         child: image,
// //       ),
// //     );
// //   }
// // }

// class SelectedFileList extends StatelessWidget {
//   SelectedFileList(
//       {required this.image, required this.title, required this.filename});

//   final Image image;
//   final String title;
//   final filename;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 30.0, right: 30.0),
//       child: InkWell(
//         child: Column(
//           children: <Widget>[
//             SizedBox(
//               height: 10.0,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 0.8.sw,
//                       child: Text(title,
//                           overflow: TextOverflow.ellipsis,
//                           style: RegText.CONTENTS_TEXT),
//                     ),
//                   ],
//                 ),
//                 InkWell(
//                   child: Icon(Icons.clear, color: Color(0xFFBCBCBC), size: 15),
//                   onTap: () => Get.defaultDialog(
//                       title: '첨부 파일 삭제',
//                       middleText: '$filename을 삭제하시겠습니까?',
//                       confirm: MaterialButton(
//                           onPressed: () async {
//                             _fileList.remove(filename);
//                             Get.back();
//                           },
//                           child: Text('확인')),
//                       cancel: MaterialButton(
//                           onPressed: () => Get.back(), child: Text('취소'))),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10.0,
//             ),
//             Container(
//               height: 0.5,
//               width: double.infinity,
//               color: Colors.black12.withOpacity(0.1),
//             )
//           ],
//         ),
//         onTap: () async {},
//       ),
//     );
//   }
// }
