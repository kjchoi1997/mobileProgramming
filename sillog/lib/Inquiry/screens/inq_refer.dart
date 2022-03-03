import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sillog/Inquiry/components/inq_sillog_content.dart';
import 'package:sillog/Inquiry/data/chip_data.dart';
import 'package:sillog/Inquiry/data/model/inq_model.dart';
import 'package:sillog/Registration/data/model/reg_model.dart';
import 'package:sillog/utils/app_colors.dart';
import 'package:sillog/utils/app_text_theme.dart';
import 'package:sillog/widgets/appbar.dart';
import 'package:sillog/widgets/tagChips.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InqRefer extends StatefulWidget {
  //연속된 실록 리스트뷰
  const InqRefer({Key? key}) : super(key: key);

  @override
  _InqReferState createState() => _InqReferState();
}

class _InqReferState extends State<InqRefer> {
  SeqSillogModel data = Get.arguments;
  Widget _sillogInfo() {
    return Container(
        width: 1.sw,
        color: SLG_COLOR,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    data.dateRange[0] == data.dateRange[1]
                        ? Text(
                            DateFormat('yyyy.MM.dd(E)', 'kor')
                                .format((data.dateRange[0])),
                            style: ThemeText_white.p1)
                        : Text(
                            '${DateFormat('yy.MM.dd(E)', 'kor').format(data.dateRange[0])} ~ ${DateFormat('yy.MM.dd(E)', 'kor').format(data.dateRange[1])}',
                            style: ThemeText_white.p1,
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        data.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              _tagWidget(data.tags),
              SizedBox(height: 15)
            ],
          ),
        ));
  }

  Widget _tagWidget(List<TagModel> tagList) {
    //상단 태그 리스트
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: tagList
            .map((tagModel) => InqTagChip(
                key: ValueKey(tagModel), tagModel: tagModel, isChecked: true))
            .toList(),
      ),
    );
  }

  Widget _getSillogList() {
    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
          nodePosition: 0.06,
          color: SLG_COLOR,
          connectorTheme:
              ConnectorThemeData(space: 10, color: Color(0xFFE8E8E8)),
          indicatorTheme: IndicatorThemeData(size: 15),
          indicatorPosition: 0.06),
      builder: TimelineTileBuilder.connectedFromStyle(
          contentsAlign: ContentsAlign.basic,
          contentsBuilder: (context, index) {
            print(data);
            print(data.sillogs.length);
            return SeqSillogContent(
                index: index,
                dataModel: data.sillogs,
                length: data.sillogs.length);
          },
          connectorStyleBuilder: (context, index) => ConnectorStyle.solidLine,
          indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
          itemCount: data.sillogs.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: () => Scaffold(
            appBar: CustomAppBar(
                title: 'sillog',
                backgroundColor: SLG_COLOR,
                color: Colors.white,
                leading: true),
            body: SingleChildScrollView(
              child: Column(children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _sillogInfo(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                    ),
                    _getSillogList(),
                  ],
                ),
              ]),
            )));
  }
}
