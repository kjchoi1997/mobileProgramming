import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';
import 'package:sillog/Registration/data/model/reg_model.dart';
import 'package:sillog/utils/const.dart';
import 'package:sillog/widgets/tagChips.dart';

class RegCategoryCard extends StatefulWidget {
  //카테고리별 태그 묶음
  RegCategoryCard({required this.category});

  final String category;

  @override
  _RegCategoryCardState createState() => _RegCategoryCardState();
}

class _RegCategoryCardState extends State<RegCategoryCard> {
  final tagController = Get.find<TagController>();

  @override
  Widget build(BuildContext context) {
    final tagController = Get.find<TagController>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("# ${widget.category}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.start,
                      children:
                          TagList[widget.category]!.map<Widget>((tagName) {
                        TagModel tagModel = TagModel(
                            category: widget.category, tagName: tagName);
                        return Obx(
                          () => TagChip(
                            tagModel: tagModel,
                            onTap: () => tagController.stateTag(tagModel),
                            isChecked:
                                tagController.selectedtags.contains(tagModel),
                          ),
                        );
                      }).toList(),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
