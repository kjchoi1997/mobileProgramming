import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sillog/Registration/controller/image_add_controller.dart';
import 'package:sillog/Registration/components/reg_iconWidget.dart';
import 'package:sillog/Registration/components/reg_imageListTile.dart';
import 'package:sillog/utils/utils.dart';

class SelectedImageList extends StatelessWidget {
  const SelectedImageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageController = Get.put(ImageListController());
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            IconWidget(icon: Icons.image_outlined),
            Text('이미지', style: RegText.HEAD_TEXT),
          ],
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                InkWell(
                  child: DottedBorder(
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Icon(
                        Icons.add,
                        color: Colors.grey,
                      ),
                    ),
                    borderType: BorderType.RRect,
                    strokeWidth: 1,
                    dashPattern: [4, 1],
                    color: Colors.grey,
                  ),
                  onTap: () {
                    print(imageController.selectedImageList.length);
                    imageController.getImage(ImageSource.gallery);
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: GetBuilder<ImageListController>(
                      init: ImageListController(),
                      builder: (context) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            for (var imagePath
                                in imageController.selectedImageList)
                              ImageListTile(imagePath),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
