import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:sillog/Inquiry/controller/inq_controller.dart';
import 'package:sillog/Inquiry/controller/tag_list_controller.dart';
import 'package:sillog/Inquiry/data/model/inq_model.dart';
import 'package:sillog/Registration/controller/image_add_controller.dart';
import 'package:sillog/Registration/data/model/reg_model.dart';
import 'package:sillog/Registration/screens/reg_complete.dart';
import 'package:sillog/data/provider/api.dart';
import 'package:sillog/data/provider/database.dart';
import 'package:sillog/data/provider/tagdb.dart';
import 'package:sillog/home/controller/user_controller.dart';
import 'dart:async';
import 'package:sillog/home/screens/home.dart';
import 'package:sillog/utils/utils.dart';
import 'file_add_list_controller.dart';
import 'package:moor/moor.dart' as moor;

class SillogController extends GetxController {
  //실록 등록 컨트롤러
  String title = '';
  String? id;
  List<String> imageList = <String>[];
  List<String> fileList = <String>[];
  List<Map<String, dynamic>> tagList = <Map<String, dynamic>>[];
  String memo = '';
  String memoHead = '';
  String memoContent = '';
  List<String> dateList = <String>[];
  List<QnaModel> qnaList = <QnaModel>[];

  @override
  void onInit() {
    super.onInit();

    title = '';
    imageList = <String>[];
    fileList = <String>[];
    tagList = <Map<String, dynamic>>[];
    memo = '';
    dateList = <String>[];
    qnaList = <QnaModel>[];
  }

  _getQnaList() {
    var tmpList = [];
    for (var i in qnaList) {
      if (i.answer != '') tmpList.add(i);
    }
    return tmpList.toList();
  }

  // 실록 수정시 Controller를 쉽게 init 가능하게 함
  updateWithSillog(DetailModel model) async {
    id = model.id;
    title = model.title;
    if (model.memo.head != '') memoHead = model.memo.head;
    if (model.memo.body != '') memoContent = model.memo.body;
    // tagList = model.tagList;
    dateList = model.dateList;
    imageList = model.imageList;

    // 이미지 초기화
    var imageListController = Get.put(ImageListController());

    imageListController.selectedImageList = model.imageList;
    imageListController.beforeImageList = [];
    imageListController.beforeImageList.addAll(model.imageList);

    fileList = model.fileList;
  }

  // file db를 업데이트

  clearController() {
    title = '';
    memo = '';
    memoHead = '';
    memoContent = '';
    imageList = <String>[];
    fileList = <String>[];
    tagList = <Map<String, dynamic>>[];
    dateList = <String>[];
    qnaList = <QnaModel>[];
    Get.find<TagController>().cleartagController();
  }

  Future<bool> sillogPostToServer(String sendPage) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "X-AUTH-TOKEN": '${Get.find<UserController>().jwt}'
    };

    // memo parsing
    if (memoHead != '') this.memo = '##$memoHead##$memoContent';

    List<String> baseNameImgList = <String>[];
    for (var imageList in this.imageList) {
      baseNameImgList.add(basename(imageList));
    }

    String body = jsonEncode(
      {
        "title": "$title",
        "qnaList": sendPage != 'template' ? null : _getQnaList(),
        "memo": sendPage != 'memo' ? null : {"body": "${this.memo}"},
        "tagList": this.tagList.toList(),
        "imageList": baseNameImgList.toList(),
        "fileList": this.fileList.toList(),
        "dateList": this.dateList.toList()
      },
    );

    http.Response sillogRegistResponse =
        await ApiClient().postApi_dynamic('/api/v1/sillogs', headers, body);

    print(
        '$title${this.memo}${this.qnaList}${this.tagList}${this.imageList}${this.fileList}${this.dateList}');
    print('Response status: ${sillogRegistResponse.statusCode}');
    print(
        '[][][][]Response body sillog: ${utf8.decode(sillogRegistResponse.bodyBytes)}');

    if (sillogRegistResponse.statusCode == 201) {
      // Sillog UPDATE DB
      var sillogId =
          json.decode(utf8.decode(sillogRegistResponse.bodyBytes))['data'];

      print('[][][][]sillogId : ' + sillogId);
      await Get.find<FileAddListController>().setLinkedSillog(sillogId);
      await Get.find<FileAddListController>().updateFile();
      await Get.find<ImageListController>().updateImgToDevice();
      await Get.find<SillogListController>().getSillogs();
      await Get.find<TagListController>().getTags();

      await Get.find<TitleController>().getTitle();

      // Sillog 초기화
      clearController();

      return true;
    } else {
      Get.snackbar('실록 알림', '실록 등록을 실패하였습니다. 다시 시도해주세요.',
          snackPosition: SnackPosition.TOP);

      return false;
    }
  }

  sillogPatchToServer() async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "X-AUTH-TOKEN": '${Get.find<UserController>().jwt}'
    };

    // memo parsing
    if (memoHead != '') this.memo = '##$memoHead##$memoContent';

    List<String> baseNameImgList = <String>[];
    for (var imageList in this.imageList) {
      baseNameImgList.add(basename(imageList));
    }

    String body = jsonEncode(
      {
        "title": "$title",
        // "qnaList": [
        //   {"question": "첫번째 질문입니다.", "answer": "첫번째 답변입니다."}
        // ],
        "qnaList": this.qnaList.isEmpty == true ? null : this.qnaList.toList(),
        "memo": this.memo == '' ? null : {"body": "${this.memo}"},
        "tagList": this.tagList.toList(),
        "imageList": baseNameImgList.toList(),
        "fileList": this.fileList.toList(),
        "dateList": this.dateList.toList()
      },
    );

    http.Response sillogRegistResponse = await ApiClient()
        .patchApi_dynamic('/api/v1/sillogs/${this.id}', headers, body);

    print(
        '$title${this.memo}${this.qnaList}${this.tagList}${this.imageList}${this.fileList}${this.dateList}');
    print('Response status: ${sillogRegistResponse.statusCode}');
    print('Response body: ${utf8.decode(sillogRegistResponse.bodyBytes)}');

    if (sillogRegistResponse.statusCode == 200) {
      // Sillog UPDATE DB
      await Get.put(FileAddListController()).setLinkedSillog(this.id!);
      await Get.find<FileAddListController>().updateFile();
      await Get.find<ImageListController>().deleteEditedImage();
      await Get.find<ImageListController>().updateImgToDevice();

      await Get.find<TitleController>().getTitle();
      await Get.find<SillogListController>().getSillogs();

      // Sillog 초기화
      clearController();

      Get.offAll(() => RegComplete(),
          transition: Transition.rightToLeftWithFade);
    } else {
      Get.snackbar('실록 알림', '실록 수정을 실패하였습니다. 다시 시도해주세요.',
          snackPosition: SnackPosition.TOP);
    }
  }

  sillogDeleteToServer(var sillogId) async {
    final userController = Get.find<UserController>();
    final sillogListController = Get.find<SillogListController>();

    http.Response deleteSillog =
        await ApiClient().deleteApi('/api/v1/sillogs/$sillogId', {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'X-AUTH-TOKEN': '${userController.jwt}'
    });

    print('Response status(DELETE): ${deleteSillog.statusCode}');
    print('Response body: ${utf8.decode(deleteSillog.bodyBytes)}');

    if (deleteSillog.statusCode == 204) {
      final deletedSillog = sillogListController.sillogsList
          .singleWhere((SillogModel) => SillogModel.id == sillogId);
      sillogListController.sillogsList.remove(deletedSillog);

      print('get Sillog');
      await Get.find<SillogListController>().getSillogs();
      Get.find<CountController>().getSillogCount();

      Get.offAll(Home(), transition: Transition.fade);
    } else {
      Get.snackbar('실록 삭제', '실록 삭제를 실패하였습니다 :(',
          snackPosition: SnackPosition.TOP);
    }
  }
}

//등록한 실록제목 이름 목록
class TitleController extends GetxController {
  List<SillogTitle> title = <SillogTitle>[];

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getTitle() async {
    final userController = Get.find<UserController>();

    http.Response titleResponse = await ApiClient().getApi(
        '/api/v1/members/${userController.id}/sillogs/title', {
      'Content-type': 'application/json',
      'X-AUTH-TOKEN': '${userController.jwt}'
    }); //실록 사용자 정보

    print('Response status: ${titleResponse.statusCode}');
    print('Response body: ${utf8.decode(titleResponse.bodyBytes)}');

    var data = json.decode(utf8.decode(titleResponse.bodyBytes))['data'] ?? [];
    this.title =
        List.generate(data.length, (idx) => SillogTitle.fromJson(data[idx]));
  }

  List<SillogTitle> getSuggestions(String query) =>
      List.of(this.title).where((title) {
        final userLower = title.title.toLowerCase();
        final queryLower = query.toLowerCase();
        return userLower.contains(queryLower);
      }).toList();
}

class CountController extends GetxController {
  //등록한 실록 개수
  int count = 0;

  @override
  void onInit() {
    super.onInit();
    getSillogCount();
  }

  Future<int> getSillogCount() async {
    final sillogController = Get.find<SillogListController>();

    this.count = sillogController.sillogsList.length;
    return count;
  }
}

class QuestionController extends GetxController {
  //기본 질문 관리
  String categoriesName = '';
}

class CustomController extends GetxController {
  //커스텀 질문 관리
  var custumQuestion = 0.obs;

  increment() => custumQuestion++;
}

class TagController extends GetxController {
  //태그 선택 관리
  RxList<TagModel> selectedtags = <TagModel>[].obs; //선택된 태그 리스트(태그모델)
  List<CategoryModel> alltags = <CategoryModel>[].obs; //전체 태그 리스트(카테고리 모델)

  stateTag(tagModel) {
    if (!this.selectedtags.contains(tagModel)) {
      this.selectedtags.add(tagModel);
    } else {
      this.selectedtags.remove(tagModel);
    }
  }

  addTag(category, tagName) async {
    // for (int i = 0; i < this.alltags.length; i++) {
    //   if (this.alltags[i].category == category) {
    //     this
    //         .alltags[i]
    //         .tagList
    //         .add(TagModel(category: category, tagName: tagName));
    //   }
    // }
    final dao = GetIt.instance<MyTagDao>();
    print('[mytagdb] add' + category + tagName);
    await dao.insertMyTag(
      MyTagCompanion(
        category: moor.Value(category),
        tagname: moor.Value(tagName),
      ),
    );
    print('[mytagdb] success to add' + category + tagName);
  }

  deleteTag(category, tagName) async {
    final dao = GetIt.instance<MyTagDao>();
    print('[mytagdb] delete' + category + tagName);
    await dao.deleteMyTag(tagName);
    print('[mytagdb] success to delete' + category + tagName);
  }

  removeTag(category, tagName) {
    for (int i = 0; i < this.alltags.length; i++) {
      if (this.alltags[i].category == category) {
        this
            .alltags[i]
            .tagList
            .remove(TagModel(category: category, tagName: tagName));
      }
    }
  }

  cleartagController() {
    selectedtags = <TagModel>[].obs;
  }

  unselectTag(TagModel tag) {
    selectedtags.remove(tag);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
