import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sillog/Registration/components/reg_selectedFileList.dart';
import 'package:sillog/Registration/components/reg_selectedImageList.dart';

// 이미지, 증명서, 상장 추가 위젯

// RxList<String> _imageList = Get.find<SillogController>().imageList;
// RxList<String> _fileList = Get.find<SillogController>().fileList;

class RegAddWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectedImageList(),
        SizedBox(height: 20),
        SelectedFileList(),
      ],
    );
  }
}
