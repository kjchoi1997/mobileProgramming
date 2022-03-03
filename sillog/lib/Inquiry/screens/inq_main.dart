import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:sillog/Inquiry/components/inq_sillog_content.dart' as Content;
import 'package:sillog/Inquiry/controller/inq_controller.dart';
import 'package:sillog/Inquiry/controller/tag_list_controller.dart';
import 'package:sillog/Registration/data/model/reg_model.dart';
import 'package:sillog/home/controller/user_controller.dart';
import 'package:sillog/utils/app_colors.dart';
import 'package:sillog/widgets/appbar.dart';
import 'package:sillog/widgets/tagChips.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InqTag extends StatefulWidget {
  const InqTag({Key? key}) : super(key: key);

  @override
  _InqTagState createState() => _InqTagState();
}

class _InqTagState extends State<InqTag> with SingleTickerProviderStateMixin {
  final userController = Get.find<UserController>();

  // List<dynamic> tagList = []; //전체 태그 리스트
  List<TagModel> _tags = []; //선택된 태그

  late final TagListController tagListController;

  @override
  initState() {
    super.initState();
    tagListController = Get.find<TagListController>();
    _tags = tagListController.selectedTagList;
  }

  bool open = false;

  //기본 상단 앱바
  _openPanel() {
    setState(() => open = true);
  }

  // 카테고리 상단 앱바
  _closePanel() {
    setState(() => open = false);
  }

  Widget _slidingUpPanel() {
    //상단 슬라이딩 패널
    return Obx(() => SlidingUpPanel(
          onPanelOpened: _openPanel,
          onPanelClosed: _closePanel,
          collapsed: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _selectedTagsWidget(),
                  ],
                ),
              ),
            ),
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          // minHeight: _tags.length > 0 ? 65 : 15,
          minHeight: 65,
          maxHeight: tagListController.usedTagList
                      .where((tagModel) => !_tags.contains(tagModel))
                      .toList()
                      .length <
                  9
              ? 100
              : tagListController.usedTagList
                          .where((tagModel) => !_tags.contains(tagModel))
                          .toList()
                          .length <
                      13
                  ? 140
                  : 180,
          header: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Color(0xFFE8E8E8),
                  ),
                  width: 45,
                  height: 5,
                )),
              )),
          panel: _displayUsedTagWidget(),
          slideDirection: SlideDirection.DOWN,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // _tags.length > 0 ? SizedBox(height: 70) : SizedBox(height: 20),
                SizedBox(height: 70),
                getSillogList(),
                SizedBox(height: 150),
              ],
            ),
          ),
        ));
  }

  Widget getSillogList() {
    var sillogListController = Get.find<SillogListController>();
    if (sillogListController.sillogsList.length == 0) {
      return sillogTimeLineBuilder(Content.NoTimeLineContent());
    } else {
      var seqSillogList = sillogListController.getSelectedTagsSillogs();
      print('seqSillogList: ${sillogListController.seqSillogList}');
      print('SillogList: ${sillogListController.sillogsList}');
      return FixedTimeline.tileBuilder(
        theme: TimelineThemeData(
            nodePosition: 0.06,
            color: SLG_COLOR,
            connectorTheme:
                ConnectorThemeData(space: 10, color: Color(0xFFE8E8E8)),
            indicatorTheme: IndicatorThemeData(size: 48),
            indicatorPosition: 0.06),
        builder: TimelineTileBuilder.connectedFromStyle(
            contentsAlign: ContentsAlign.basic,
            contentsBuilder: (context, index) {
              return seqSillogList[index].sillogs.length == 1
                  ? Content.SillogContent(
                      index: index, dataModel: seqSillogList[index].sillogs[0])
                  : Content.SillogsContent(
                      index: index, dataModel: seqSillogList[index]);
            },
            connectorStyleBuilder: (context, index) => ConnectorStyle.solidLine,
            indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
            itemCount: seqSillogList.length),
      );
    }
  }

  FixedTimeline sillogTimeLineBuilder(Widget content) {
    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
          nodePosition: 0.06,
          color: SLG_COLOR,
          connectorTheme:
              ConnectorThemeData(space: 10, color: Color(0xFFE8E8E8)),
          indicatorTheme: IndicatorThemeData(size: 48),
          indicatorPosition: 0.03),
      builder: TimelineTileBuilder.connectedFromStyle(
          contentsAlign: ContentsAlign.basic,
          contentsBuilder: (context, index) {
            return content;
          },
          connectorStyleBuilder: (context, index) => ConnectorStyle.solidLine,
          indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
          itemCount: 1),
    );
  }

  //상단 패널 기존에 사용했던 태그 위젯
  Widget _displayUsedTagWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Obx(() => Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  children: tagListController.usedTagList
                      // .where((tagModel) => !_tags.contains(tagModel))
                      .map((tagModel) => InqTagChip(
                            key: ValueKey(tagModel),
                            tagModel: tagModel,
                            isChecked: tagListController.selectedTagList
                                .contains(tagModel),
                          ))
                      .toList(),
                ),
              ))
        ]),
      ),
    );
  }

  Widget _selectedTagsWidget() {
    //선택된 태그 위젯
    if (tagListController.usedTagList.length == 0) return Container(height: 0);

    return Obx(() => tagListController.usedTagList.length < 4
        ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Wrap(
              alignment: WrapAlignment.start,
              children: tagListController.usedTagList
                  .map((tagModel) => InqTagChip(
                        key: ValueKey(tagModel),
                        tagModel: tagModel,
                        isChecked: tagListController.selectedTagList
                            .contains(tagModel),
                      ))
                  .toList(),
            ),
          ])
        : tagListController.selectedTagList.length == 0
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  children: tagListController.usedTagList
                      .getRange(tagListController.usedTagList.length - 3,
                          tagListController.usedTagList.length)
                      .map((tagModel) => InqTagChip(
                            key: ValueKey(tagModel),
                            tagModel: tagModel,
                            isChecked: tagListController.selectedTagList
                                .contains(tagModel),
                          ))
                      .toList(),
                ),
              ])
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  children: tagListController.selectedTagList
                      .map((tagModel) => InqTagChip(
                            key: ValueKey(tagModel),
                            tagModel: tagModel,
                            isChecked: tagListController.selectedTagList
                                .contains(tagModel),
                          ))
                      .toList(),
                ),
              ]));
  }

  @override
  Widget build(BuildContext context) {
    // tagList = List.generate(
    //   tagData[0]['data'].length,
    //   (idx) => List.generate(
    //     tagData[0]['data'][idx]['tagNameList'].length,
    //     (index) => TagModel(
    //       category: tagData[0]['data'][idx]['category'],
    //       tagName: tagData[0]['data'][idx]['tagNameList'][index],
    //     ),
    //   ),
    // );
    return ScreenUtilInit(
        builder: () => Scaffold(
            appBar:
                CustomAppBar(title: 'sillog', color: SLG_COLOR, leading: false),
            body: _slidingUpPanel()));
  }
}
