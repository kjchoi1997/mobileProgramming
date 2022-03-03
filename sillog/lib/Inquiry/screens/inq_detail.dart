import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sillog/FileManage/screens/pdf_view.dart';
import 'package:sillog/Inquiry/components/gallery_item.dart';
import 'package:sillog/Inquiry/screens/gallery_view.dart';
import 'package:sillog/Inquiry/components/inq_floatAction.dart';
import 'package:sillog/Inquiry/data/model/inq_model.dart';
import 'package:sillog/Inquiry/screens/inq_edit.dart';
import 'package:sillog/Registration/data/model/reg_model.dart';
import 'package:sillog/data/provider/database.dart';
import 'package:sillog/data/provider/filedb.dart';
import 'package:sillog/home/components/slg_bottom_navigation_menu.dart';
import 'package:sillog/home/controller/user_controller.dart';
import 'package:path/path.dart';
import 'package:sillog/utils/utils.dart';
import 'package:sillog/widgets/appbar.dart';
import 'package:sillog/widgets/tagChips.dart';
import 'package:sillog/widgets/widgets.dart';

class InqDetail extends StatefulWidget {
  InqDetail({required this.data, required this.sequence});
  final SillogModel data;
  final bool sequence;

  @override
  _InqDetailState createState() => _InqDetailState();
}

class _InqDetailState extends State<InqDetail> {
  final userController = Get.find<UserController>();

  Widget _sillogInfo() {
    return Container(
        width: 1.sw,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.data.dateList.length == 1
                        ? Text(
                            DateFormat('yyyy.MM.dd(E)', 'kor').format(
                                DateTime.parse(widget.data.dateList[0])),
                            style: ThemeText.p1)
                        : Text(
                            '${DateFormat('yy.MM.dd(E)', 'kor').format(DateTime.parse(widget.data.dateList[0]))} ~ ${DateFormat('yy.MM.dd(E)', 'kor').format(DateTime.parse(widget.data.dateList[1]))}',
                            style: ThemeText.p1,
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        widget.data.title,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              _tagWidget(widget.data.tagList, widget.sequence),
            ],
          ),
        ));
  }

  Widget _sillogSeqInfo() {
    return Container(
        width: 1.sw,
        color: SLG_COLOR,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.data.dateList.length == 1
                        ? Text(
                            DateFormat('yyyy.MM.dd(E)', 'kor').format(
                                DateTime.parse(widget.data.dateList[0])),
                            style: ThemeText_white.p1)
                        : Text(
                            '${DateFormat('yy.MM.dd(E)', 'kor').format(DateTime.parse(widget.data.dateList[0]))} ~ ${DateFormat('yy.MM.dd(E)', 'kor').format(DateTime.parse(widget.data.dateList[1]))}',
                            style: ThemeText_white.p1,
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        widget.data.title,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              _tagWidget(widget.data.tagList, widget.sequence),
            ],
          ),
        ));
  }

  Widget _tagWidget(List<TagModel> tagList, bool sequence) {
    //상단 태그 리스트
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: tagList
            .map((tagModel) => InqTagChip(
                  key: ValueKey(tagModel),
                  tagModel: tagModel,
                  isChecked: sequence,
                  onTap: () {},
                ))
            .toList(),
      ),
    );
  }

  Widget _memoWidget(MemoModel memo) {
    //메모 위젯
    return memo == MemoModel(head: '', body: '')
        ? SizedBox(height: 0)
        : Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child:
                            SelectableText('${memo.head}', style: ThemeText.p1),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: SelectableText(
                          '${memo.body}',
                          style: ThemeText.normal,
                        ),
                      )
                    ]),
              ),
            ),
          );
  }

  Widget _questionWidget(List<QnaModel> qnaList) {
    //질문 리스트
    return qnaList.isEmpty == true
        ? SizedBox(
            height: 0,
          )
        : Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: qnaList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return questionChip(
                                tempModel: qnaList[index],
                              );
                            }),
                      ]),
                )),
          );
  }

  Widget questionChip({tempModel}) {
    //질문 위젯
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text('${tempModel.question}', style: ThemeText.p1),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Text('${tempModel.answer}', style: ThemeText.normal),
        ),
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
        : Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text('이미지', style: ThemeText.p1),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: SingleChildScrollView(
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
                                              galleryItems:
                                                  _toGalleryList(imageList),
                                              initialIndex: index,
                                            ));
                                      });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
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
              return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text('증명서 / 상장', style: ThemeText.p1),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, bottom: 20.0),
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: fileList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var data = snapshot.data![index];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        fileChip(basename(data.appPath),
                                            data.category),
                                      ],
                                    );
                                  }))

                          // StreamBuilder<List<UserFileData>>(
                          //     stream: dao.streamLinkedSillog(id),
                          //     builder: (context, snapshot) {
                          //       if (snapshot.hasData) {
                          //         final List<UserFileData> docFileList = snapshot.data!;
                          //         return Column(
                          //             crossAxisAlignment: CrossAxisAlignment.start,
                          //             children: List.generate(
                          //               docFileList.length,
                          //                   (index) => fileChip(
                          //                   docFileList[index].title +
                          //                       docFileList[index].extension,
                          //                   DateFormat('yyyy-MM-dd')
                          //                       .format(docFileList[index].createdAt),
                          //                   "manage"),
                          //             ));
                          //       } else {
                          //         return CircularProgressIndicator();
                          //       }
                          //     }),
                        ],
                      ),
                    ),
                  ));
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DetailModel.getDetail(widget.data),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData == false) {
          return Scaffold(
            appBar: CustomAppBar(title: 'sillog', leading: true),
            bottomNavigationBar: SLGBottomNavigationMenu(),
            body: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      height: 0.5,
                      color: UNSELECT_COLOR),
                  _sillogInfo(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      LOADING_INDICATOR,
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
              appBar: widget.sequence == true
                  ? CustomAppBar(
                      title: 'sillog',
                      color: Colors.white,
                      backgroundColor: SLG_COLOR,
                      leading: true)
                  : CustomAppBar(title: 'sillog', leading: true),
              floatingActionButton: InqFloatAction(sillog: snapshot.data),
              bottomNavigationBar: SLGBottomNavigationMenu(ishome: false),
              body: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    widget.sequence == true
                        ? _sillogSeqInfo()
                        : Column(
                            children: [
                              Container(
                                  width: double.infinity,
                                  height: 0.5,
                                  color: UNSELECT_COLOR),
                              _sillogInfo(),
                            ],
                          ),
                    Column(
                      children: [
                        _questionWidget(snapshot.data.qnaList),
                        _memoWidget(snapshot.data.memo),
                        _imageWidget(snapshot.data.imageList),
                        _fileWidget(snapshot.data.fileList, snapshot.data.id),
                      ],
                    )
                  ],
                ),
              ));
        }
      },
    );
  }
}
