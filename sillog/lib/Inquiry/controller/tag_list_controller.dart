import 'dart:convert';

import 'package:get/get.dart';
import 'package:sillog/Inquiry/data/model/model.dart';
import 'package:sillog/Registration/data/model/reg_model.dart';
import 'package:sillog/data/provider/api.dart';
import 'package:sillog/home/controller/user_controller.dart';
import 'package:http/http.dart' as http;

class TagListController extends GetxController {
  //사용한 태그 리스트 정보
  List<SillogModel> tagList = <SillogModel>[];

  RxList<TagModel> usedTagList = <TagModel>[].obs;
  RxList<TagModel> selectedTagList = <TagModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
  }

  addTag(TagModel selectedTag) {
    if (!selectedTagList.contains(selectedTag))
      selectedTagList.add(selectedTag);

    update();
    return;
  }

  deleteTag(TagModel selectedTag) {
    if (selectedTagList.contains(selectedTag))
      selectedTagList.remove(selectedTag);

    return;
  }

  // 사용자가 사용한 실록 태그 리스트를 받아옴
  getTags() async {
    final userController = Get.find<UserController>();

    http.Response tagResponse = await ApiClient().getApi('/api/v1/tags/me', {
      'Content-type': 'application/json',
      'X-AUTH-TOKEN': '${userController.jwt}'
    }); //

    print('Response status(Tags): ${tagResponse.statusCode}');
    print('Response body: ${utf8.decode(tagResponse.bodyBytes)}');

    String responseBody = utf8.decode(tagResponse.bodyBytes);

    // 사용한 태그의 리스트를 Map<String, List<String>> 으로 저장
    var tmpUsedTagList = jsonDecode(responseBody)['data'] ?? [];
    print(tmpUsedTagList);
    Map<String, List<String>> usedTagMap = {};

    for (var i = 0; i < tmpUsedTagList.length; i++) {
      String category = tmpUsedTagList[i]['category'];
      usedTagMap[category] = List.generate(
          tmpUsedTagList[i]['tagNameList'].length,
          (index) => tmpUsedTagList[i]['tagNameList'][index]);
    }
    print(usedTagList);

    usedTagMap.forEach((key, value) {
      for (var tag in value) {
        TagModel tmp = TagModel(category: key, tagName: tag);
        if (!usedTagList.contains(tmp)) usedTagList.add(tmp);
      }
    });
  }
}
