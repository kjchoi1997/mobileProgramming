import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sillog/Registration/controller/image_add_controller.dart';
import 'package:sillog/utils/utils.dart';
import 'package:sillog/widgets/dialog.dart';

class ImageListTile extends StatelessWidget {
  ImageListTile(this.file);

  final String file;
  final iamgeController = Get.put(ImageListController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          InkWell(
            child: Container(
              child: Image.file(
                File(file),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            onTap: () {},
          ),
          InkWell(
            child: Container(
              color: Colors.white30,
              child: Icon(
                Icons.close_outlined,
                size: 20,
                color: Colors.black,
              ),
            ),
            onTap: () {
              SLG_Dialog.defaultDialog(
                title: '첨부파일 삭제',
                middleText: '이미지를 삭제하시겠습니까',
                textConfirm: '삭제',
                onConfirm: () {
                  iamgeController.deleteFile(file);
                  Get.back();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
