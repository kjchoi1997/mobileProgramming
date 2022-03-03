import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sillog/Inquiry/inq_tag.dart';

import '../chip_data.dart';

class InqDetail extends StatefulWidget {
  const InqDetail({Key? key}) : super(key: key);

  @override
  _InqDetailState createState() => _InqDetailState();
}

class _InqDetailState extends State<InqDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: PageView(
          children: <Widget>[
            for (var i = 0; i < 5; i++)
              makeCard()
          ],
        ),
      ),
    );
  }

}
class makeCard extends StatelessWidget{

  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: () => Scaffold(
          backgroundColor: Color(0x163C6B),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              blurRadius: 3.0,
                              spreadRadius: 1.0)
                        ]),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              '21.07.02(Fri)',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(15),
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(120),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(30),
                              height: ScreenUtil().setHeight(30),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.assignment_outlined,
                                    color: Colors.black54,
                                  )),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(30),
                              height: ScreenUtil().setHeight(30),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.open_in_new_outlined,
                                    color: Colors.black54,
                                  )),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(40),
                              height: ScreenUtil().setHeight(30),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.black54,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              '개발 이벤트',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(20),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Wrap(
                                spacing: 0.5,
                                runSpacing: 1,
                                children:
                                detailchip.asMap().entries.map((entry) {
                                  int idx = entry.key;
                                  return buildChip(
                                    idx,
                                    entry.value['label'].toString(),
                                    entry.value['color'].toString(),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                    Icons.map
                                ),
                                Text(
                                  '실록',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                              height: 10,
                            ),
                            Container(
                              height: 150.0,
                              width: 300.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [BoxShadow(color: Colors.black12)],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                              height: 10,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 30,
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                                Icons.map
                            ),
                            Text(
                              '이미지 실록',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 150,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  child: imageCard(
                                    colorTop: Colors.black12,
                                    colorBottom: Color(0xFFF5AE87),
                                    image: "assets/sticker/Whale12.png",
                                    title: "1",
                                  ),
                                ),
                                InkWell(
                                  child: imageCard(
                                    colorTop: Colors.black12,
                                    colorBottom: Color(0xFFF5AE87),
                                    image: "assets/sticker/Whale12.png",
                                    title: "2",
                                  ),
                                ),
                                InkWell(
                                  child: imageCard(
                                    colorTop: Colors.black12,
                                    colorBottom: Color(0xFFF5AE87),
                                    image: "assets/sticker/Whale15-2.png",
                                    title: "3",
                                  ),
                                ),
                                InkWell(
                                  child: imageCard(
                                    colorTop: Colors.black12,
                                    colorBottom: Color(0xFFF5AE87),
                                    image: "assets/sticker/Whale25.png",
                                    title: "4",
                                  ),
                                ),
                                InkWell(
                                  child: imageCard(
                                    colorTop: Colors.black12,
                                    colorBottom: Color(0xFFF5AE87),
                                    image: "assets/sticker/Whale31-2.png",
                                    title: "5",
                                  ),
                                ),
                              ]
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                                Icons.map
                            ),
                            Text(
                              '수상 이력 및 증명서',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Icon(
                                Icons.map
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 150,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  child: imageCard(
                                    colorTop: Colors.black12,
                                    colorBottom: Color(0xFFF5AE87),
                                    image: "assets/sticker/Whale12.png",
                                    title: "1",
                                  ),
                                ),
                                InkWell(
                                  child: imageCard(
                                    colorTop: Colors.black12,
                                    colorBottom: Color(0xFFF5AE87),
                                    image: "assets/sticker/Whale12.png",
                                    title: "2",
                                  ),
                                ),
                                InkWell(
                                  child: imageCard(
                                    colorTop: Colors.black12,
                                    colorBottom: Color(0xFFF5AE87),
                                    image: "assets/sticker/Whale15-2.png",
                                    title: "3",
                                  ),
                                ),
                                InkWell(
                                  child: imageCard(
                                    colorTop: Colors.black12,
                                    colorBottom: Color(0xFFF5AE87),
                                    image: "assets/sticker/Whale25.png",
                                    title: "4",
                                  ),
                                ),
                                InkWell(
                                  child: imageCard(
                                    colorTop: Colors.black12,
                                    colorBottom: Color(0xFFF5AE87),
                                    image: "assets/sticker/Whale31-2.png",
                                    title: "5",
                                  ),
                                ),
                              ]
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                          ),
                          height: 45.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Color(0xFFBE6C5B)),
                          child: IconButton(
                            icon: Icon(Icons.delete_forever, size: 30,color: Colors.white,),
                            onPressed: (){},
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
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
}

class imageCard extends StatelessWidget {
  Color colorTop, colorBottom;
  String image, title;
  imageCard({required this.colorTop, required this.colorBottom, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
      child: Container(
        height: 200.0,
        width: 120.0,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 8.0, color: Colors.black12)],
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          gradient: LinearGradient(
              colors: [colorTop, colorBottom],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
              const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white, fontFamily: "Sofia", fontSize: 18.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    image,
                    height: 90,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
