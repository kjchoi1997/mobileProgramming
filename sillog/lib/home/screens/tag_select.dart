import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TagSelect extends StatefulWidget {
  @override
  _TagSelectState createState() => _TagSelectState();
}

class _TagSelectState extends State<TagSelect> {
  List<TagModel> _tags = [];
  final List<TagModel> _tagsToSelect = [
    TagModel(id: '1', title: '# 공모전'),
    TagModel(id: '2', title: '# 대회'),
    TagModel(id: '3', title: '# 블록체인'),
    TagModel(id: '4', title: '# 스프링'),
    TagModel(id: '5', title: '# 자바'),
    TagModel(id: '6', title: '# 플러터'),
    TagModel(id: '7', title: '# 프론트'),
    TagModel(id: '8', title: '# 백엔드'),
  ];

  _stateTag(tagModel) async {
    if (!_tags.contains(tagModel)) {
      setState(() {
        _tags.add(tagModel);
      });
    } else {
      setState(() {
        _tags.remove(tagModel);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('태 그 선 택', style: TextStyle(color: Colors.white)),
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
              onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Text("관심 분야 태그 3개를 선택해주세요!",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text('내가 등록할 활동들에 붙일\n자주 쓸만한 관심 분야 태그를 선택해주세요.',
                style: TextStyle(fontSize: 12.sp, color: Color(0xFFA3A3A3)),
                textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: _displayTagWidget(),
          ),
          SizedBox(height: 0.4.sh),
          Padding(
            padding: const EdgeInsets.fromLTRB(35.0, 10.0, 35.0, 10.0),
            child: ElevatedButton(
                child: Text(
                  "선 택 완 료",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 47.h),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    primary: Color(0xFF163C6B)),
                onPressed: () {}),
          ),
        ],
      ),
    );
  }

  Widget _displayTagWidget() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Wrap(
        alignment: WrapAlignment.start,
        children: _tagsToSelect
            .map((tagModel) => tagChip(
                  tagModel: tagModel,
                  onTap: () => _stateTag(tagModel),
                  color: _tags.contains(tagModel)
                      ? Color(0xFF224D82)
                      : Color(0xFF91A2B8),
                ))
            .toList(),
      ),
    ]);
  }

  Widget tagChip({
    tagModel,
    onTap,
    color,
  }) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 2.5.w,
            horizontal: 2.5.w,
          ),
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 3.0,
                        spreadRadius: 1.0)
                  ]),
              child: Text(
                '${tagModel.title}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TagModel {
  String id;
  String title;

  TagModel({
    required this.id,
    required this.title,
  });
}
