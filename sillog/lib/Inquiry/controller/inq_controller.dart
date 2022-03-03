import 'dart:convert';
import 'package:get/get.dart';
import 'package:sillog/Inquiry/controller/tag_list_controller.dart';
import 'package:sillog/Inquiry/data/model/inq_model.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';
import 'package:sillog/Registration/data/model/reg_model.dart';
import 'package:sillog/data/provider/api.dart';
import 'package:sillog/home/controller/user_controller.dart';
import 'package:http/http.dart' as http;

class SillogListController extends GetxController {
  //등록된 실록 리스트 정보
  List<SillogModel> sillogsList = <SillogModel>[];
  List<SeqSillogModel> seqSillogList = <SeqSillogModel>[];

  Future<List<SeqSillogModel>> getSillogs() async {
    final userController = Get.find<UserController>();
    final List<dynamic> titles = Get.find<TitleController>().title;
    print('user id : ${userController.id}');
    print('user jwt: ${userController.jwt}');
    http.Response sillogResponse = await ApiClient().getApi(
        '/api/v1/members/${userController.id}/sillogs', {
      'Content-type': 'application/json',
      'X-AUTH-TOKEN': '${userController.jwt}'
    }); //사용자 실록 정보

    if (sillogResponse.statusCode == 200) {
      print('Response status(Sillogs): ${sillogResponse.statusCode}');
      print('Response body: ${utf8.decode(sillogResponse.bodyBytes)}');

      var data =
          json.decode(utf8.decode(sillogResponse.bodyBytes))['data'] ?? [];
      this.sillogsList =
          List.generate(data.length, (idx) => SillogModel.fromJson(data[idx]));

      this.seqSillogList = List.generate(
          titles.length,
          (index) => SeqSillogModel(
                title: '${titles[index].title}',
                tags: [],
                sillogs: [],
              ));

      for (int i = 0; i < seqSillogList.length; i++) {
        //이름 기준 묶음
        List<SillogModel> seqSillog = sillogsList
            .where((sillogModel) => sillogModel.title == seqSillogList[i].title)
            .toList();
        seqSillogList[i].sillogs = seqSillog;

        //태그 묶음
        Set tagstemp = Set();
        for (int x = 0; x < seqSillogList[i].sillogs.length; x++) {
          tagstemp.addAll(seqSillogList[i].sillogs[x].tagList);
        }
        seqSillogList[i].tags = tagstemp.toList().cast<TagModel>();
      }

      return seqSillogList;
    } else {
      // 만약 요청이 실패하면, 에러를 던짐
      print('실록 요청 실패');
      throw Exception('요청 실패');
    }
  }

  // 실록 연속된 실록 구별하기

  List<SeqSillogModel> getSelectedTagsSillogs() {
    // List<SeqSillogModel> selectedSillogs = List.generate(
    //     sillogsList.length,
    //     (index) => SeqSillogModel(
    //           title: '${sillogsList[index].title}',
    //           sillogs: [],
    //         ));

    List<SeqSillogModel> selectedSillogs = [];
    var tagList = Get.find<TagListController>().selectedTagList;
    var seqSillogList = Get.find<SillogListController>().seqSillogList;

    for (var sillogsList in seqSillogList) {
      var tmpList = <SillogModel>[];
      for (var sillog in sillogsList.sillogs) {
        bool containFlag = true;

        for (var tag in tagList) {
          if (!sillog.tagList.contains(tag)) {
            containFlag = false;
            break;
          }
        }
        if (containFlag) tmpList.add(sillog);
      }
      if (tmpList.length > 0)
        selectedSillogs.add(SeqSillogModel(
            title: sillogsList.title,
            tags: sillogsList.tags,
            sillogs: tmpList));
    }

    return selectedSillogs;
  }
}
