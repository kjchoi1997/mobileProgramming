import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sillog/FileManage/screens/pdf_view.dart';
import 'package:sillog/Inquiry/components/gallery_item.dart';
import 'package:sillog/Inquiry/controller/seq_floataction_controller.dart';
import 'package:sillog/Inquiry/screens/gallery_view.dart';
import 'package:sillog/Inquiry/components/inq_floatAction.dart';
import 'package:sillog/Inquiry/data/model/inq_model.dart';
import 'package:sillog/Inquiry/screens/inq_details.dart';
import 'package:sillog/Inquiry/screens/inq_edit.dart';
import 'package:sillog/Registration/data/model/reg_model.dart';
import 'package:sillog/data/provider/database.dart';
import 'package:sillog/data/provider/filedb.dart';
import 'package:sillog/home/controller/user_controller.dart';
import 'package:path/path.dart';
import 'package:sillog/utils/utils.dart';
import 'package:sillog/widgets/tagChips.dart';
import 'package:sillog/widgets/widgets.dart';

// category - contentPadding
const double CATEGORY_CONTENT_PAD = 16;
const double CATEGORY_CATEGORY_PAD = 30;

class InqDetailSeq extends StatefulWidget {
  InqDetailSeq({required this.index});

  final int index;

  @override
  _InqDetailSeqState createState() => _InqDetailSeqState();
}

class _InqDetailSeqState extends State<InqDetailSeq> {
  final userController = Get.find<UserController>();

  Widget _sillogInfo() {
    final sillogData =
        Get.find<FloatActionController>().sillogData[widget.index];

    return Container(
        width: 1.sw,
        color: SLG_COLOR,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sillogData.dateList.length == 1
                    ? Text(
                        DateFormat('yyyy.MM.dd(E)', 'kor')
                            .format(DateTime.parse(sillogData.dateList[0])),
                        style: ThemeText_white.p1)
                    : Text(
                        '${DateFormat('yy.MM.dd(E)', 'kor').format(DateTime.parse(sillogData.dateList[0]))} ~ ${DateFormat('yy.MM.dd(E)', 'kor').format(DateTime.parse(sillogData.dateList[1]))}',
                        style: ThemeText_white.p1,
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    sillogData.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            _tagWidget(sillogData.tagList),
          ],
        ));
  }

  Widget _tagWidget(List<TagModel> tagList) {
    //상단 태그 리스트
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: tagList
            .map((tagModel) => InqTagChip(
                key: ValueKey(tagModel), tagModel: tagModel, isChecked: true))
            .toList(),
      ),
    );
  }

  Widget _memoWidget(MemoModel memo) {
    //메모 위젯
    return memo == MemoModel(head: '', body: '')
        ? SizedBox(height: 0)
        : Container(
            width: double.infinity,
            color: Colors.white,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Memo', style: ThemeText.p1),
              SizedBox(height: CATEGORY_CONTENT_PAD),
              // Padding(
              //   padding: const EdgeInsets.only(top: 20.0),
              //   child: Text('${memo.head}', style: ThemeText.p1),
              // ),
              SelectableText(
                '${memo.body}',
                style: ThemeText.normal,
              )
            ]),
          );
  }

  Widget _questionWidget(List<QnaModel> qnaList) {
    //질문 리스트
    return qnaList.isEmpty == true
        ? SizedBox(
            height: 0,
          )
        : Container(
            width: double.infinity,
            color: Colors.white,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: qnaList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return questionChip(
                      tempModel: qnaList[index],
                    );
                  }),
            ]));
  }

  Widget questionChip({tempModel}) {
    //질문 위젯
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText('${tempModel.question}', style: ThemeText.p1),
        SizedBox(height: CATEGORY_CONTENT_PAD),
        SelectableText('${tempModel.answer}', style: ThemeText.normal),
        SizedBox(height: CATEGORY_CATEGORY_PAD),
      ],
    );
  }

  RxList<GalleryItem> _toGalleryList(List<String> imageList) {
    RxList<GalleryItem> galleryItems = RxList<GalleryItem>();

    imageList.asMap().forEach((key, value) {
      GalleryItem gItem = GalleryItem(id: key.toString(), resource: value);
      galleryItems.add(gItem);
    });

    return galleryItems;
  }

  Widget _imageWidget(List<String> imageList) {
    //이미지 리스트
    return imageList.isEmpty == true
        ? SizedBox(height: 0)
        : Container(
            width: double.infinity,
            color: Colors.white,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('이미지', style: ThemeText.p1),
              SizedBox(height: 15),
              SingleChildScrollView(
                child: SizedBox(
                  width: 0.9.sw,
                  height: imageList.length <= 3 ? 125 : 250,
                  child: GridView.count(
                    // physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: List.generate(
                      imageList.length,
                      (index) {
                        return GalleryItemThumbnail(
                            galleryItem: GalleryItem(
                                id: index.toString(),
                                resource: imageList[index]),
                            onTap: () {
                              Get.to(() => GalleryPhotoViewWrapper(
                                    galleryItems: _toGalleryList(imageList),
                                    initialIndex: index,
                                  ));
                            });
                      },
                    ),
                  ),
                ),
              ),
            ]),
          );
  }

  Widget imageChip(String imagePath) {
    //이미지 위젯
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        child: Container(
          width: 0.3.sw,
          color: Colors.grey,
          child: Image.file(File(imagePath), fit: BoxFit.fill),
        ),
        onTap: () {},
      ),
    );
  }

  Widget _fileWidget(List<String> fileList, String id) {
    //파일 리스트
    final dao = GetIt.instance<UserFileDao>();

    return StreamBuilder<List<UserFileData>>(
        stream: dao.streamLinkedSillog(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              return Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('증명서 / 상장', style: ThemeText.p1),
                    SizedBox(height: CATEGORY_CONTENT_PAD),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: fileList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = snapshot.data![index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              fileChip(basename(data.appPath), data.category),
                            ],
                          );
                        })
                  ],
                ),
              );
            } else
              return Container();
          } else {
            return Container();
          }
        });
  }

  Widget fileChip(String title, String category) {
    //파일 위젯
    return InkWell(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(height: 15, width: 15, color: sillogColor),
              Flexible(
                fit: FlexFit.tight,
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 0.5.sw,
                        child: Text(title,
                            overflow: TextOverflow.ellipsis,
                            style: ThemeText.normal),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 5.0),
                    color: SLG_COLOR,
                    child: Center(
                      child: Text(category,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: fontNameDefault,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  )),
              // Flexible(
              //     fit: FlexFit.tight,
              //     flex: 2,
              //     child: Text(manage,
              //         overflow: TextOverflow.ellipsis,
              //         style: ThemeText.normal)),
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
      onTap: () async {
        var appPath = await getApplicationDocumentsDirectory();
        var pdfPath = join(appPath.path, title);
        print(pdfPath);
        Get.to(PDFScreen(
          path: pdfPath,
        ));
      },
    );
  }

  _headText(headText) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              headText,
              style: ThemeText.h1,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.chevron_left_sharp),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.chevron_right_sharp),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SLG_COLOR,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          _sillogInfo(),
          GetBuilder<FloatActionController>(builder: (controller) {
            if (controller.isLoading) {
              return Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  WHITE_LOADING_INDICATOR,
                ],
              );
            } else {
              print('set index ${Get.find<FloatActionController>().index}');
              DetailModel detailSillog = Get.find<FloatActionController>()
                  .detailsSillogMap[widget.index]!;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                detailSillog.qnaList.length == 0
                                    ? _headText(detailSillog.memo.head)
                                    : _headText(detailSillog.qnaList[0].answer),
                                SizedBox(height: CATEGORY_CONTENT_PAD),
                                _questionWidget(detailSillog.qnaList),
                                _memoWidget(detailSillog.memo),
                                SizedBox(height: CATEGORY_CATEGORY_PAD),
                                _imageWidget(detailSillog.imageList),
                                SizedBox(height: CATEGORY_CATEGORY_PAD),
                                _fileWidget(
                                    detailSillog.fileList, detailSillog.id),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
        ]),
      ),
    );
  }
}
