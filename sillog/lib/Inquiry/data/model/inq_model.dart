import 'dart:convert';

import 'package:sillog/Inquiry/controller/inq_controller.dart';
import 'package:sillog/Registration/controller/image_add_controller.dart';
import 'package:sillog/Registration/data/model/reg_model.dart';
import 'package:sillog/data/provider/api.dart';
import 'package:http/http.dart' as http;
import 'package:sillog/home/controller/user_controller.dart';
import 'package:sillog/utils/utils.dart';

// 실록 전체 조회시 기본 데이터
class SillogModel {
  final String id;
  final String title;
  final List<QnaModel> qnaList;
  final MemoModel memo;
  final List<TagModel> tagList;
  final List<String> dateList;

  SillogModel({
    required this.id,
    required this.title,
    required this.qnaList,
    required this.memo,
    required this.tagList,
    required this.dateList,
  });

  @override
  toString() {
    return 'id:$id, title:$title';
  }

  factory SillogModel.fromJson(Map<String, dynamic> json) {
    return SillogModel(
      id: json['id'] as String,
      title: json['title'] as String,
      qnaList: json['qnaList'] == null
          ? []
          : List.generate(json['qnaList']?.length,
              (idx) => QnaModel.fromJson(json['qnaList'][idx])),
      // qnaList: json['qnaList']?.cast<QnaList>()?? [],
      memo: json['memo'] == null
          ? MemoModel(head: '', body: '')
          : MemoModel.fromJson(json['memo']),
      tagList: List.generate(json['tagList'].length,
          (idx) => TagModel.fromJson(json['tagList'][idx])),
      // tagList: json['tagList']?.cast<TagList>(),
      dateList: json['dateList']?.cast<String>(),
    );
  }

  dynamic get getTitle => title;
}

class SeqSillogModel {
  //연속된 실록 관리
  final String title;
  List<TagModel> tags;
  List<SillogModel> sillogs;
  List<DateTime> dateRange = [];

  List<DateTime> _getDateRange(tmpsillogs) {
    if (tmpsillogs.length == 0) return [];
    DateTime min = DateTime.parse(tmpsillogs[0].dateList[0]);
    DateTime max = DateTime.parse(tmpsillogs[0].dateList.last);

    for (var date in tmpsillogs) {
      var first = DateTime.parse(date.dateList[0]);
      var last = DateTime.parse(date.dateList.last);

      if (first.isBefore(min)) min = first;
      if (max.isBefore(last)) max = last;
    }
    dateRange = [min, max];
    return [min, max];
  }

  @override
  toString() {
    var strList =
        List.generate(sillogs.length, (index) => sillogs[index].memo.head);
    return '$title: ${strList.toString()} ';
  }

  // SeqSillogModel({required this.title, required this.tags, required this.sillogs});
  SeqSillogModel(
      {required this.title, required this.tags, required this.sillogs}) {
    dateRange = _getDateRange(this.sillogs);
  }
}

// 실록 세부조회시 데이터
class DetailModel {
  final String id;
  final String title;
  final List<QnaModel> qnaList;
  final MemoModel memo;
  final List<TagModel> tagList;
  final List<String> dateList;
  List<String> imageList;
  List<String> fileList;

  DetailModel(
      {required this.id,
      required this.title,
      required this.qnaList,
      required this.memo,
      required this.tagList,
      required this.dateList,
      required this.imageList,
      required this.fileList});

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
      id: json['id'] as String,
      title: json['title'] as String,
      qnaList: json['qnaList'] == null
          ? []
          : List.generate(json['qnaList']?.length,
              (idx) => QnaModel.fromJson(json['qnaList'][idx])),
      memo: json['memo'] == null
          ? MemoModel(head: '', body: '')
          : MemoModel.fromJson(json['memo']),
      tagList: List.generate(json['tagList'].length,
          (idx) => TagModel.fromJson(json['tagList'][idx])),
      dateList: json['dateList']?.cast<String>(),
      imageList: json['imageList']?.cast<String>() ?? [],
      fileList: json['fileList']?.cast<String>() ?? [],
    );
  }

  static getAppImagePath(List<String> getImgList) async {
    List<String> imgList = [];
    imgList..addAll(getImgList);

    List<String> appImgPathList = [];

    var appDir = await getApplicationDocumentsDirectory();

    for (var imgName in imgList) {
      String appImgPath = join(appDir.path, 'img', imgName);
      appImgPathList.add(appImgPath);
    }

    return appImgPathList;
  }

  static Future<DetailModel> getDetail(var sillog) async {
    var sillogId = sillog.id;
    DetailModel detail;
    final userController = Get.find<UserController>();

    print(userController.id);
    print(sillogId);
    http.Response sillogDetail = await ApiClient()
        .getApi('/api/v1/members/${userController.id}/sillogs/$sillogId', {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'X-AUTH-TOKEN': '${userController.jwt}'
    });

    if (sillogDetail.statusCode == 200) {
      print('Response status(Sillogs): ${sillogDetail.statusCode}');
      print('Response body: ${utf8.decode(sillogDetail.bodyBytes)}');
      print(json.decode(utf8.decode(sillogDetail.bodyBytes))['data']);

      detail = DetailModel.fromJson(
          json.decode(utf8.decode(sillogDetail.bodyBytes))['data']);

      detail.imageList = await getAppImagePath(detail.imageList);
      return detail;
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<DetailModel> getDetails(var sillog) async {
    var sillogId = sillog.id;
    DetailModel detail;
    final userController = Get.find<UserController>();

    print(userController.id);
    print(sillogId);
    http.Response sillogDetail = await ApiClient()
        .getApi('/api/v1/members/${userController.id}/sillogs/$sillogId', {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'X-AUTH-TOKEN': '${userController.jwt}'
    });

    if (sillogDetail.statusCode == 200) {
      print('Response status(Sillogs): ${sillogDetail.statusCode}');
      print('Response body: ${utf8.decode(sillogDetail.bodyBytes)}');
      print(json.decode(utf8.decode(sillogDetail.bodyBytes))['data']);

      detail = DetailModel.fromJson(
          json.decode(utf8.decode(sillogDetail.bodyBytes))['data']);

      detail.imageList = await getAppImagePath(detail.imageList);
      return detail;
    } else {
      throw Exception('Failed to load post');
    }
  }
}

class MemoModel {
  final String head;
  final String body;

  MemoModel({required this.head, required this.body});

  bool operator ==(other) {
    return (other is MemoModel && other.head == head && other.body == body);
  }

  factory MemoModel.fromJson(Map<String, dynamic> json) {
    return MemoModel(
      head: json['body'].toString().substring(
          json['body'].toString().indexOf("##") + "##".length,
          json['body'].toString().indexOf(
              "##", json['body'].toString().indexOf("##") + "##".length)),
      body: json['body'].toString().substring(json['body']
              .toString()
              .substring(
                  json['body'].toString().indexOf("##") + "##".length,
                  json['body'].toString().indexOf("##",
                      json['body'].toString().indexOf("##") + "##".length))
              .length +
          4),
    );
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
