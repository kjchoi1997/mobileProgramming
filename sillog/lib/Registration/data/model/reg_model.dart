import 'package:get/get.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';

class SillogTitle {
  final String title;
  final String regDate;

  const SillogTitle({
    required this.title,
    required this.regDate,
  });

  factory SillogTitle.fromJson(Map<String, dynamic> json) {
    return SillogTitle(
      title: json['title'].toString(),
      regDate: json['regDate'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'regDate': regDate,
      };
}

class QnaModel {
  String question;
  String answer;

  QnaModel({
    required this.question,
    required this.answer,
  });

  factory QnaModel.fromJson(Map<String, dynamic> json) {
    return QnaModel(
      question: json['question'].toString(),
      answer: json['answer'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'question': question,
        'answer': answer,
      };
}

class TagModel {
  String category;
  String tagName;

  TagModel({
    required this.category,
    required this.tagName,
  });

  bool operator ==(other) {
    return (other is TagModel &&
        other.category == category &&
        other.tagName == tagName);
  }

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      category: json['category'].toString(),
      tagName: json['name'].toString(),
    );
  }

  // TagModel.fromJson(Map<String, dynamic> json)
  //     : category = json['category'],
  //       tagName = json['name'];
  //
  Map<String, dynamic> toJson() => {
        'category': category,
        'name': tagName,
      };

  dynamic get getName => tagName;

  @override
  // TODO: implement hashCode
  int get hashCode => category.hashCode + tagName.hashCode;
}

class CategoryModel {
  String category;
  List<TagModel> tagList;

  CategoryModel({
    required this.category,
    required this.tagList,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      category: json['category'] as String,
      tagList: List.generate(
          json['tagNameList'].length,
          (idx) => TagModel(
              category: json['category'], tagName: json['tagNameList'][idx])),
    );
  }

  Map<String, dynamic> toJson() => {
        'category': category,
        'tagNameList':
            List.generate(tagList.length, (idx) => tagList[idx].tagName),
      };
}
