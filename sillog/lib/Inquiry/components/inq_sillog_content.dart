import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sillog/Inquiry/components/inq_tagchip_mini.dart';
import 'package:sillog/Inquiry/data/model/inq_model.dart';
import 'package:sillog/Inquiry/screens/inq_detail.dart';
import 'package:sillog/Inquiry/screens/inq_details.dart';
import 'package:sillog/Inquiry/screens/inq_refer.dart';
import 'package:sillog/Registration/screens/reg_eventInfo.dart';
import 'package:sillog/utils/app_colors.dart';
import 'package:sillog/utils/app_text_theme.dart';

class SillogContent extends StatelessWidget {
  //단일 실록
  const SillogContent({
    Key? key,
    required this.index,
    required this.dataModel,
  }) : super(key: key);
  final int index;
  final SillogModel dataModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 15.0, right: 20.0, top: 10.0, bottom: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (dataModel.dateList == null || dataModel.dateList.length == 0)
                Text(
                  '21.',
                  style: TextStyle(
                      fontFamily: fontNameDefault,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF555555)),
                )
              else
                dataModel.dateList.length == 1
                    ? Text(
                        DateFormat('yy.MM.dd(E)', 'kor')
                            .format(DateTime.parse(dataModel.dateList[0])),
                        style: TextStyle(
                            fontFamily: fontNameDefault,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF555555)),
                      )
                    : Text(
                        '${DateFormat('yy.MM.dd(E)', 'kor').format(DateTime.parse(dataModel.dateList[0]))} ~ ${DateFormat('yy.MM.dd(E)', 'kor').format(DateTime.parse(dataModel.dateList[1]))}',
                        style: TextStyle(
                            fontFamily: fontNameDefault,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF555555)),
                      ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 20.0,
                      spreadRadius: 2.0)
                ]),
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 15.0, 5.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(dataModel.title, style: ThemeText.p1),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Color(0xFFBCBCBC), size: 17)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Wrap(
                          children:
                              dataModel.tagList.asMap().entries.map((entry) {
                            int idx = entry.key;
                            return InqTagChipMini(
                                index: idx,
                                tagData: dataModel.tagList,
                                length: dataModel.tagList.length);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              onTap: () {
                print('sillogModel ID' + dataModel.id);
                Get.to(InqDetail(data: dataModel, sequence: false),
                    transition: Transition.native);
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class SillogsContent extends StatelessWidget {
  //연속 실록
  const SillogsContent({
    Key? key,
    required this.index,
    required this.dataModel,
  }) : super(key: key);
  final int index;
  final SeqSillogModel dataModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 15.0, right: 20.0, top: 10.0, bottom: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${DateFormat('yy.MM.dd(E)', 'kor').format(dataModel.dateRange[0])} ~ ${DateFormat('yy.MM.dd(E)', 'kor').format(dataModel.dateRange[1])}',
                style: TextStyle(
                    fontFamily: fontNameDefault,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF555555)),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Get.to(InqRefer(),
                  arguments: dataModel, transition: Transition.native);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: SLG_COLOR,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${dataModel.sillogs[0].title}',
                          style: TextStyle(
                              fontFamily: fontNameDefault,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        Text(
                          '총${dataModel.sillogs.length}개',
                          style: TextStyle(
                              fontFamily: fontNameDefault,
                              fontSize: 12,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 2.0,
                                spreadRadius: 2.0)
                          ]),
                      child: InkWell(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 5.0, 15.0, 5.0),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                dataModel.sillogs[0].dateList.length == 1
                                    ? Text(
                                        DateFormat('yy.MM.dd(E)', 'kor').format(
                                            DateTime.parse(dataModel
                                                .sillogs[0].dateList[0])),
                                        style: TextStyle(
                                            fontFamily: fontNameDefault,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF555555)),
                                      )
                                    : Text(
                                        '${DateFormat('yy.MM.dd(E)', 'kor').format(DateTime.parse(dataModel.sillogs[0].dateList[0]))} ~ ${DateFormat('yy.MM.dd(E)', 'kor').format(DateTime.parse(dataModel.sillogs[0].dateList[1]))}',
                                        style: TextStyle(
                                            fontFamily: fontNameDefault,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF555555)),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                dataModel.sillogs[0].memo ==
                                        MemoModel(head: '', body: '')
                                    ? Text(
                                        dataModel.sillogs[0].qnaList[0].answer,
                                        style: ThemeText.p1)
                                    : Text(dataModel.sillogs[0].memo.head,
                                        style: ThemeText.p1),
                                Icon(Icons.arrow_forward_ios,
                                    color: Color(0xFFBCBCBC), size: 17)
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ]),
                        ),
                        onTap: () {
                          print(dataModel.sillogs[0].id);
                          Get.to(InqDetails(data: dataModel.sillogs, idx: 0),
                              transition: Transition.native);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0)
                            ]),
                        child: InkWell(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 5.0, 15.0, 5.0),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  dataModel.sillogs[1].dateList.length == 1
                                      ? Text(
                                          DateFormat('yy.MM.dd(E)', 'kor')
                                              .format(DateTime.parse(dataModel
                                                  .sillogs[1].dateList[0])),
                                          style: TextStyle(
                                              fontFamily: fontNameDefault,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF555555)),
                                        )
                                      : Text(
                                          '${DateFormat('yy.MM.dd(E)', 'kor').format(DateTime.parse(dataModel.sillogs[1].dateList[0]))} ~ ${DateFormat('yy.MM.dd(E)', 'kor').format(DateTime.parse(dataModel.sillogs[1].dateList[1]))}',
                                          style: TextStyle(
                                              fontFamily: fontNameDefault,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF555555)),
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  dataModel.sillogs[1].memo ==
                                          MemoModel(head: '', body: '')
                                      ? Text(
                                          dataModel
                                              .sillogs[1].qnaList[0].answer,
                                          style: ThemeText.p1)
                                      : Text(dataModel.sillogs[1].memo.head,
                                          style: ThemeText.p1),
                                  Icon(Icons.arrow_forward_ios,
                                      color: Color(0xFFBCBCBC), size: 17)
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ]),
                          ),
                          onTap: () {
                            print(dataModel.sillogs[1].id);
                            Get.to(InqDetails(data: dataModel.sillogs, idx: 1),
                                transition: Transition.native);
                          },
                        ),
                      ),
                    ),
                    Icon(Icons.more_horiz, color: Color(0xFFBCBCBC), size: 25)
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class SeqSillogContent extends StatelessWidget {
  //연속 실록 리스트
  const SeqSillogContent({
    Key? key,
    required this.length,
    required this.index,
    required this.dataModel,
  }) : super(key: key);
  final int index;
  final List<SillogModel> dataModel;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 15.0, right: 20.0, top: 10.0, bottom: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              dataModel[index].dateList.length == 1
                  ? Text(
                      DateFormat('yy.MM.dd(E)', 'kor')
                          .format(DateTime.parse(dataModel[index].dateList[0])),
                      style: TextStyle(
                          fontFamily: fontNameDefault,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF555555)),
                    )
                  : Text(
                      '${DateFormat('yy.MM.dd(E)', 'kor').format(DateTime.parse(dataModel[index].dateList[0]))} ~ ${DateFormat('yy.MM.dd(E)', 'kor').format(DateTime.parse(dataModel[index].dateList[1]))}',
                      style: TextStyle(
                          fontFamily: fontNameDefault,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF555555)),
                    ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsetsDirectional.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 20.0,
                      spreadRadius: 2.0)
                ]),
            child: InkWell(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        dataModel[index].memo == MemoModel(head: '', body: '')
                            ? Text(dataModel[index].qnaList[0].answer,
                                style: ThemeText.p1)
                            : Text(dataModel[index].memo.head,
                                style: ThemeText.p1),
                        SizedBox(height: 15),
                        dataModel[index].memo == MemoModel(head: '', body: '')
                            ? Text(dataModel[index].qnaList[0].answer,
                                style: ThemeText.normal)
                            : Text(dataModel[index].memo.body,
                                style: ThemeText.normal),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios,
                        color: Color(0xFFBCBCBC), size: 17)
                  ],
                ),
              ]),
              onTap: () {
                Get.to(InqDetails(data: dataModel, idx: index),
                    transition: Transition.native);
              },
            ),
          ),
          SizedBox(
            height: index == length - 1 ? 0.3.sh : 10,
          ),
        ],
      ),
    );
  }
}

class NoTimeLineContent extends StatelessWidget {
  const NoTimeLineContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 15.0, right: 20.0, top: 10.0, bottom: 10.0),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                DateFormat('yy.MM.dd(E)', 'kor').format(DateTime.now()),
                style: TextStyle(
                    fontFamily: fontNameDefault,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF555555)),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 2.0,
                      spreadRadius: 2.0)
                ]),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 5.0, 15.0, 10.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('새로운 카드를 만들어 주세요.', style: ThemeText.p1),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: DottedBorder(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          child: Icon(
                            Icons.add,
                            color: SLG_COLOR,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    borderType: BorderType.RRect,
                    strokeWidth: 1,
                    dashPattern: [4, 1],
                    color: Color(0xFFC4C4C4),
                  ),
                  onTap: () {
                    Get.to(RegEventInfo(), transition: Transition.native);
                  },
                ),
              ]),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.announcement,
                  color: LINE_COLOR,
                  size: 20,
                ),
              ),
              Text(
                '아직 생성된 카드가 없어요',
                style: TextStyle(
                  fontFamily: fontNameDefault,
                  fontSize: 12,
                  color: LINE_COLOR,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                Container(child: Image.asset('assets/image/no_timeline.png')),
          ),
        ],
      ),
    );
  }
}
