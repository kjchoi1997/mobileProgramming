import 'dart:io';

import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sillog/FileManage/components/file_preview.dart';
import 'package:sillog/FileManage/controller/file_controller.dart';
import 'package:sillog/FileManage/controller/file_list_controller.dart';
import 'package:sillog/FileManage/screens/image_list.dart';

import 'package:sillog/FileManage/screens/pdf_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sillog/utils/utils.dart';
import 'package:sillog/widgets/dialog.dart';
import 'package:sillog/widgets/widgets.dart';

class UserFileCard extends StatefulWidget {
  final String title;
  final String extension;
  final int size;
  final DateTime createdAt;
  final int id;
  final Color? backgroundColor;
  final String linkedSillog;

  UserFileCard(
      {required this.id,
      this.backgroundColor,
      required this.title,
      required this.extension,
      required this.size,
      required this.createdAt,
      required this.linkedSillog});

  @override
  _UserFileCardState createState() => _UserFileCardState();
}

class _UserFileCardState extends State<UserFileCard> {
  late Function previewFunc;
  late final controller;
  @override
  initState() {
    super.initState();
    controller = Get.put(FileListController());
  }

  Future<String> getAppDir() async {
    var appDir = await getApplicationDocumentsDirectory();
    String appPath = p.join(appDir.path, widget.title + widget.extension);
    return appPath;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(Radius.circular(10.0)),
          color: controller.isSelected(widget.id)
              ? Colors.blue.shade50
              : Colors.white,
        ),
        child: InkWell(
          onTap: controller.isSelectMode()
              ? () {
                  setState(() {
                    controller.selectFile(
                        widget.id, widget.title + widget.extension);
                  });
                }
              : () async {
                  String appPath = await getAppDir();
                  bool ifExists = File(appPath).existsSync();

                  if (!ifExists)
                    Get.defaultDialog(
                        title: '에러',
                        contentPadding: EdgeInsets.zero,
                        content: Center(
                          child: Column(
                            children: [
                              Text('파일을 찾지 못했어요'),
                              Text('삭제를 진행할까요?'),
                            ],
                          ),
                        ),
                        confirm: BottomButton(
                          text: '삭제',
                          onPressed: () {
                            // DB에서 제거
                            FileController.deleteFile(widget.id, appPath);
                            Get.back();
                          },
                        ));
                  switch (extension(appPath)) {
                    case '.pdf':
                      Get.to(PDFScreen(
                        path: appPath,
                        sillogId: widget.linkedSillog,
                      ));
                      break;

                    default:
                      SLG_Dialog.apologizeDialog(
                        middleText:
                            '죄송합니다:(\n지금은 pdf만 조회 할 수 있어요.\n트리링이 더 열심히 일할게요!',
                        title: '앗!',
                      );
                  }
                },
          onLongPress: controller.isSelectMode()
              ? () {}
              : () async {
                  controller.changeMode();
                  controller.selectFile(
                      widget.id, widget.title + widget.extension);
                },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              renderFilePreview(),
              renderTitle(),
            ],
          ),
        ),
      );
    });
  }

  renderFilePreview() {
    return Container(
        child: FilePreview(extension: widget.extension, width: 70, height: 70));
  }

  renderTitle() {
    final ca = widget.createdAt;

    final dateStr = '${ca.year}-${ca.month}-${ca.day}';

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          filesize(widget.size),
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        Text(
          dateStr,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class PhotoFolder extends StatelessWidget {
  const PhotoFolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
          onTap: () {
            Get.to(ImageListPage());
          },
          child: Column(
            children: [
              FilePreview(extension: 'folder', width: 70, height: 70),
              Text(
                '이미지',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
    );
  }
}

class FileViewerRoute extends StatelessWidget {
  const FileViewerRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
