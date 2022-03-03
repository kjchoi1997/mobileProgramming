import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sillog/chip_data.dart';

class InqRefer extends StatefulWidget {
  const InqRefer({Key? key}) : super(key: key);

  @override
  _InqReferState createState() => _InqReferState();
}

class _InqReferState extends State<InqRefer> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: () => Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFF163C6B),
                title: Text('sillog'),
                elevation: 0.0,
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    print('Hamburger!');
                  },
                ),
                actions: <Widget>[
                  IconButton(
                      onPressed: () {
                        print('Search!');
                      },
                      icon: Icon(Icons.search)),
                  IconButton(
                      onPressed: () {
                        print('Out!');
                      },
                      icon: Icon(Icons.open_in_new_outlined))
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          height: ScreenUtil().setHeight(150),
                          decoration: BoxDecoration(
                            color: Color(0xFF163C6B),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(ScreenUtil().setSp(25)), bottomRight: Radius.circular(ScreenUtil().setSp(25)))
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  '알고리즘 스터디',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(20),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(40),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    spacing: 1,
                                    children:
                                    concerns.asMap().entries.map((entry) {
                                      int idx = entry.key;
                                      return buildChip2(
                                        idx,
                                        entry.value['label'].toString(),
                                        entry.value['color'].toString(),
                                      );
                                    }).toList(),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(30),
                                  ),
                                  Text('월 1회', style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                    ),
                    FixedTimeline.tileBuilder(
                      theme: TimelineThemeData(
                          nodePosition: ScreenUtil().setWidth(0.1),
                          color: Color(0xFF163C6B)),
                      builder: TimelineTileBuilder.connectedFromStyle(
                        contentsAlign: ContentsAlign.basic,
                        oppositeContentsBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                        ),
                        contentsBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '21. 07. 02(FRI)',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(13),
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                              Container(
                                // height: 280.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Colors.black12.withOpacity(0.1),
                                          blurRadius: 3.0,
                                          spreadRadius: 1.0)
                                    ]),
                                child: Column(children: [
                                  SizedBox(
                                    height: ScreenUtil().setHeight(10),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: ScreenUtil().setWidth(10),
                                        ),
                                        Text(
                                          "개발이벤트",
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Wrap(
                                      spacing: 0.5,
                                      runSpacing: 1,
                                      children:
                                          concerns.asMap().entries.map((entry) {
                                        int idx = entry.key;
                                        return buildChip(
                                          idx,
                                          entry.value['label'].toString(),
                                          entry.value['color'].toString(),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        connectorStyleBuilder: (context, index) =>
                            ConnectorStyle.dashedLine,
                        indicatorStyleBuilder: (context, index) =>
                            IndicatorStyle.dot,
                        itemCount: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget buildChip(int index, String label, String color) {
    if (index <= 2) {
      return Transform(
        transform: new Matrix4.identity()..scale(0.8),
        child: Chip(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(ScreenUtil().setSp(7)),
                  bottomRight: Radius.circular(ScreenUtil().setSp(7)),
                  topLeft: Radius.circular(ScreenUtil().setSp(7)),
                  bottomLeft: Radius.circular(ScreenUtil().setSp(7)))),
          label: Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF163C6B),
        ),
      );
    } else {
      return Transform(
        transform: new Matrix4.identity()..scale(0.8),
        child: Chip(
          label: Text(
            (index + 1).toString(),
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
      );
    }
  }

  Widget buildChip2(int index, String label, String color) {
    if (index <= 2) {
      return Transform(
        transform: new Matrix4.identity()..scale(0.7),
        child: Chip(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(ScreenUtil().setSp(7)),
                  bottomRight: Radius.circular(ScreenUtil().setSp(7)),
                  topLeft: Radius.circular(ScreenUtil().setSp(7)),
                  bottomLeft: Radius.circular(ScreenUtil().setSp(7)))),
          label: Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF3E5D84),
        ),
      );
    } else {
      return Transform(
        transform: new Matrix4.identity()..scale(0.7),
/*        child: Chip(
          label: Text(
            (index + 1).toString(),
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),*/
      );
    }
  }
}
