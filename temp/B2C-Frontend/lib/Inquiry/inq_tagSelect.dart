import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sillog/Registration/reg_refer.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sillog/chip_data.dart';

class InqTagSelect extends StatefulWidget {
  const InqTagSelect({Key? key}) : super(key: key);

  @override
  _InqTagSelectState createState() => _InqTagSelectState();
}

class _InqTagSelectState extends State<InqTagSelect> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: () => Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF163C6B),
            title: Text('sillog'),
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
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 0.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(

                            height: ScreenUtil().setHeight(30),
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: ScreenUtil().setWidth(100),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: ScreenUtil().setWidth(25),
                                          ),
                                          Text('# ??????',
                                              style: TextStyle(
                                                fontSize:
                                                ScreenUtil().setSp(20),
                                                fontWeight: FontWeight.bold,
                                              )),

                                        ],
                                      )),
                                ],
                              ),
                              onTap: () {},

                            ),
                          ),
                          Container(
                            height: ScreenUtil().setHeight(50),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                SizedBox(
                                  width: ScreenUtil().setWidth(25),
                                ),
                                InkWell(
                                  child: Container(
                                      child: Center(
                                          child: Text('# ??????',
                                              style: TextStyle(
                                                  fontSize: ScreenUtil().setSp(13),
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: Colors.black54)))),
                                  onTap: () {},
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(15),
                                ),
                                InkWell(
                                  child: Container(
                                      child: Center(
                                          child: Text('# ?????????',
                                              style: TextStyle(
                                                  fontSize:
                                                  ScreenUtil().setSp(13),
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54)))),
                                  onTap: () {},
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(15),
                                ),
                                InkWell(
                                  child: Container(
                                      child: Center(
                                          child: Text('# ????????????',
                                              style: TextStyle(
                                                  fontSize:
                                                  ScreenUtil().setSp(13),
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54)))),
                                  onTap: () {},
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(15),
                                ),
                                InkWell(
                                  child: Container(
                                      child: Center(
                                          child: Text('# ???????????????',
                                              style: TextStyle(
                                                  fontSize:
                                                  ScreenUtil().setSp(13),
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54)))),
                                  onTap: () {},
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(15),
                                ),
                                InkWell(
                                  child: Container(
                                      child: Center(
                                          child: Text('# ??????',
                                              style: TextStyle(
                                                  fontSize:
                                                  ScreenUtil().setSp(13),
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54)))),
                                  onTap: () {},
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(15),
                                ),
                                InkWell(
                                  child: Container(
                                      child: Center(
                                          child: Text('# ??????6',
                                              style: TextStyle(
                                                  fontSize:
                                                  ScreenUtil().setSp(13),
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54)))),
                                  onTap: () {},
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(15),
                                ),
                                InkWell(
                                  child: Container(
                                      child: Center(
                                          child: Text('# ??????7',
                                              style: TextStyle(
                                                  fontSize:
                                                  ScreenUtil().setSp(13),
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54)))),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                FixedTimeline.tileBuilder(
                  theme: TimelineThemeData(
                      nodePosition: ScreenUtil().setWidth(0.1), color: Color(0xFF163C6B)),
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
                            height: ScreenUtil().setHeight(261),
                            decoration: BoxDecoration(
                              color: Color(0xFF224D82),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                                boxShadow: [
                            BoxShadow(
                            color:
                            Colors.black12.withOpacity(0.1),
                              blurRadius: 3.0,
                              spreadRadius: 1.0)
                            ]),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '???????????? ?????????',
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(17),
                                          fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(90),
                                    ),
                                    Text(
                                      '??? 1???',
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(15),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 20, 13, 13),
                                  child: Container(
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
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: ScreenUtil().setWidth(10),
                                            ),
                                            Text(
                                              "???????????????",
                                              style: TextStyle(
                                                fontSize: ScreenUtil().setSp(15),
                                              ),
                                            ),
                                            SizedBox(
                                              width: ScreenUtil().setWidth(75),
                                            ),
                                            Text(
                                              "21.06.02(Fri)",
                                              style: TextStyle(
                                                fontSize: ScreenUtil().setSp(15),
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black54
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Container(
                                          height: 60,

                                          decoration: BoxDecoration(
                                              color: Colors.white38,
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(10.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color:
                                                    Colors.black12.withOpacity(0.1),
                                                    spreadRadius: 1.0)
                                              ]),
                                          child: Center(
                                            child: Text(
                                              '   ???????????? ????????? ????????? ????????? ??????...\n ?????? ??????????????????'
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                                Text(
                                  '...',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(17),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    connectorStyleBuilder: (context, index) =>
                    ConnectorStyle.dashedLine,
                    indicatorStyleBuilder: (context, index) =>
                    IndicatorStyle.dot,
                    itemCount: 5,
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(ScreenUtil().setSp(7)),bottomRight: Radius.circular(ScreenUtil().setSp(7)), topLeft: Radius.circular(ScreenUtil().setSp(7)), bottomLeft: Radius.circular(ScreenUtil().setSp(7)))),
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
}
class one extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: ScreenUtil().setWidth(10),
                    ),
                    Text(
                      "???????????????",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(15),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                                color:
                                Colors.black12.withOpacity(0.1),
                                spreadRadius: 1.0)
                          ]),
                      child: Text(
                          '   ???????????? ????????? ????????? ????????? ??????...\n ?????? ??????????????????'
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
    throw UnimplementedError();
  }

}
class many extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}

