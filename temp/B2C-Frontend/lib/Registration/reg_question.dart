import 'dart:io';
import 'package:get/get.dart';

// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:http_parser/http_parser.dart';

class RegQuestion extends StatefulWidget {
  @override
  _RegQuestionState createState() => _RegQuestionState();
}

class _RegQuestionState extends State<RegQuestion> {
  final picker = ImagePicker();
  File ?_image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.99),
      appBar: AppBar(
        title: const Text('등 록', style: TextStyle(color: Colors.white)),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 0.1.h),
          child: LinearProgressIndicator(
            color: Color(0xFF163C6B),
            backgroundColor: Color(0xFFC4C4C4),
            value: 0.50,
          ),
        ),
        backgroundColor: Color(0xFF163C6B),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context); //뒤로가기
            },
            color: Colors.white,
            icon: Icon(Icons.navigate_before)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_next),
            color: Colors.white,
            onPressed: () =>
                Get.to(RegTag(), transition: Transition.rightToLeftWithFade),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text("원하는 질문에 답변을 작성해주세요!",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 40.0, bottom: 10.0),
              child: Container(
                // height: 280.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12.withOpacity(0.1),
                          blurRadius: 3.0,
                          spreadRadius: 1.0)
                    ]),
                child: Column(children: [
                  ExpansionTile(
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    title: Row(
                      children: [
                        Text("Q1. ",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.bold)),
                        Text("첫번째 질문입니다.",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    trailing: Icon(
                      Icons.add,
                      color: Color(0xFF05528C),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 15),
                        child: TextField(
                          maxLines: 7,
                          style: TextStyle(fontSize: 12.sp),
                          decoration: InputDecoration(
                              isCollapsed: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: '답변을 작성해주세요.',
                              hintStyle: TextStyle(
                                  color: Color(0xFFB9B9B9), fontSize: 12.sp)),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
              child: Container(
                // height: 280.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12.withOpacity(0.1),
                          blurRadius: 3.0,
                          spreadRadius: 1.0)
                    ]),
                child: Column(children: [
                  ExpansionTile(
                    title: Row(
                      children: [
                        Text("Q2. ",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.bold)),
                        Text("두번째 질문입니다.",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    trailing: Icon(
                      Icons.add,
                      color: Color(0xFF05528C),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 15),
                        child: TextField(
                          maxLines: 7,
                          style: TextStyle(fontSize: 12.sp),
                          decoration: InputDecoration(
                              isCollapsed: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: '답변을 작성해주세요.',
                              hintStyle: TextStyle(
                                  color: Color(0xFFB9B9B9), fontSize: 12.sp)),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
              child: Container(
                // height: 280.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12.withOpacity(0.1),
                          blurRadius: 3.0,
                          spreadRadius: 1.0)
                    ]),
                child: Column(children: [
                  ExpansionTile(
                    title: Text(
                      "혹시 참여한 사진이 있나요?",
                    ),
                    trailing: Icon(
                      Icons.add,
                      color: Color(0xFF05528C),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12.withOpacity(0.1),
                                    blurRadius: 3.0,
                                    spreadRadius: 1.0)
                              ]),
                          child: Center(
                            child: _image == null
                                // ignore: deprecated_member_use
                                ? IconButton(
                                    onPressed: getImage,
                                    icon: Icon(
                                      Icons.image,
                                      color: Colors.grey,
                                    ))
                                : Image.file(
                                    _image,
                                    width: 100,
                                    height: 100,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
              child: Container(
                // height: 280.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12.withOpacity(0.1),
                          blurRadius: 3.0,
                          spreadRadius: 1.0)
                    ]),
                child: Column(children: [
                  ExpansionTile(
                    title: Text(
                      "혹시 첨부할 증명서가 있나요?",
                    ),
                    trailing: Icon(
                      Icons.add,
                      color: Color(0xFF05528C),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12.withOpacity(0.1),
                                    blurRadius: 3.0,
                                    spreadRadius: 1.0)
                              ]),
                          child: Center(
                            child: _image == null
                                // ignore: deprecated_member_use
                                ? IconButton(
                                    onPressed: getImage,
                                    icon: Icon(
                                      Icons.add_to_photos,
                                      color: Colors.grey,
                                    ))
                                : Image.file(
                                    _image,
                                    width: 100,
                                    height: 100,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
              child: Container(
                // height: 280.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12.withOpacity(0.1),
                          blurRadius: 3.0,
                          spreadRadius: 1.0)
                    ]),
                child: Column(children: [
                  ExpansionTile(
                    title: Text(
                      "추가하는 첫번째 질문입니다",
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 15),
                        child: TextField(
                          maxLines: 3,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: ElevatedButton(
                child: Text(
                  "작 성 완 료",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 47.h),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    primary: Color(0xFF163C6B)),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegTag()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        // postReq();
      } else {}
    });
  }

// Future<void> postReq() async {
//   Response response;
//   Dio dio = new Dio();
//   try {
//     String filename = _image.path.split('/').last;
//     FormData data = new FormData.fromMap({
//       "file": await MultipartFile.fromFile(_image.path,
//           filename: filename, contentType: new MediaType('image', 'png')),
//       "type": "image/png"
//     });
//     response = await dio.post("http://10.0.2.2:8000/upload",
//         data: data,
//         options: Options(headers: {
//           "accept": "*/*",
//           "Content-Type": "multipart/form-data",
//         }, method: "POST"));
//     print(response.data.toString());
//   } catch (e) {
//     print(e);
//   }
// }
}
