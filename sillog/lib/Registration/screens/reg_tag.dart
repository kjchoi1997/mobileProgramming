import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sillog/Registration/components/reg_categoryCard.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';
import 'package:sillog/Registration/data/model/model.dart';
import 'package:sillog/data/provider/database.dart';
import 'package:sillog/data/provider/tagdb.dart';
import 'package:sillog/utils/app_colors.dart';
import 'package:sillog/utils/app_text_theme.dart';
import 'package:sillog/utils/const.dart';
import 'package:sillog/widgets/buttons.dart';
import 'package:sillog/widgets/snackbar.dart';
import 'package:sillog/widgets/tagChips.dart';
import 'package:sillog/widgets/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sillog/Registration/screens/reg_complete.dart';

class RegTag extends StatefulWidget {
  RegTag();

  @override
  RegTagState createState() => new RegTagState();
}

class RegTagState extends State<RegTag> with SingleTickerProviderStateMixin {
  final tagController = Get.find<TagController>();
  final sillogController = Get.find<SillogController>();
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> _getMyTag(myTagList) {
    List<Widget> tempList = <Widget>[];

    tempList.add(AddChip());
    for (var myTag in myTagList) {
      final tagModel = TagModel(
        category: myTag.category,
        tagName: myTag.tagname,
      );

      tempList.add(Obx(() => TagChip(
            tagModel: tagModel,
            onTap: () => tagController.stateTag(tagModel),
            isChecked: tagController.selectedtags.contains(tagModel),
            onLongPress: () => tagController.deleteTag('사용자', myTag.tagname),
          )));
    }

    return tempList;
  }

  Widget _slidingUpPanel() {
    final dao = GetIt.instance<MyTagDao>();

    return Obx(
      () => SlidingUpPanel(
        header: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Color(0xFFE8E8E8),
                ),
                width: 45,
                height: 5,
              )),
            )),
        minHeight: tagController.selectedtags.length > 0 ? 120 : 70,
        maxHeight: tagController.selectedtags.length < 6 ? 150 : 180,
        panel: _selectedTagWidget(),
        body: Stack(
          children: [
            TabBarView(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: TagList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RegCategoryCard(
                        category: TagList.keys.toList()[index]);
                  },
                ),
                StreamBuilder<List<MyTagData>>(
                    stream: dao.streamMyTag(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "# 사용자 태그",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, bottom: 5.0),
                                child: Container(
                                  child: Wrap(
                                      alignment: WrapAlignment.start,
                                      children: _getMyTag(data)),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
              ],
              controller: _tabController,
            ),
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
    );
  }

  Widget _selectedTagWidget() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Obx(
        () => SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              '총 ${tagController.selectedtags.length}개',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, color: SLG_COLOR),
            ),
            SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: tagController.selectedtags
                        .map<Widget>((tagModel) => TagChipX(
                              tagModel: tagModel,
                              icon: Icons.close,
                              onTap: () => tagController.stateTag(tagModel),
                              isChecked: true,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sendPage = Get.arguments; // 메모, 템플릿 실록 구분
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScroller) {
          return <Widget>[
            SliverAppBar(
              title: Text(
                '등 록',
                style: TextStyle(color: SLG_COLOR),
              ),
              leading: IconButton(
                  onPressed: () => Get.back(),
                  color: Colors.white,
                  icon: Icon(Icons.navigate_before, color: SLG_COLOR)),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScroller,
              centerTitle: true,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: SLG_COLOR,
                labelColor: SELECT_COLOR,
                unselectedLabelColor: UNSELECT_COLOR,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                tabs: [
                  Tab(
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "기본 태그",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Tab(
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "나의 태그",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
                controller: _tabController,
              ),
            )
          ];
        },
        body: _slidingUpPanel(),
      ),
      bottomNavigationBar: BottomRecButton(
        text: '선 택 완 료',
        onPressed: () async {
          sillogController.tagList =
              tagController.selectedtags.map((e) => e.toJson()).toList();
          if (tagController.selectedtags.length > 0) {
            await Get.defaultDialog(
              title: '기록 중',
              barrierDismissible: false,
              titleStyle: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: SLG_COLOR),
              backgroundColor: Colors.white,
              radius: 10,
              titlePadding: EdgeInsets.only(top: 30),
              contentPadding: EdgeInsets.all(30),
              content: FutureBuilder(
                  future: sillogController.sillogPostToServer(sendPage),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == false) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('실록을 기록하고 있습니다.', style: ThemeText.normal),
                          // Text('감사합니다 :)', style: ThemeText.normal),
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(child: LOADING_INDICATOR),
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return CircularProgressIndicator();
                    } else {
                      Get.back();
                      return Container();
                    }
                  }),
            );

            Get.offAll(() => RegComplete(),
                transition: Transition.rightToLeftWithFade);
            print(sillogController.tagList);
          } else {
            SLG_Snackbar.alertSnackBar('태그를 한 개 이상 선택해주세요 :)');
          }
        },
      ),
    );
  }
}

class MyTagView extends StatelessWidget {
  const MyTagView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
