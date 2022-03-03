import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sillog/FileManage/components/file_add_btn.dart';
import 'package:sillog/FileManage/components/file_card.dart';
import 'package:sillog/FileManage/components/file_chip.dart';
import 'package:sillog/FileManage/controller/file_list_controller.dart';
import 'package:sillog/FileManage/screens/share_view.dart';
import 'package:sillog/data/provider/database.dart';
import 'package:sillog/data/provider/filedb.dart';
import 'package:sillog/utils/app_colors.dart';
import 'package:sillog/utils/const.dart';
import 'package:sillog/widgets/appbar.dart';
import 'package:sillog/widgets/widgets.dart';

class FileList extends StatefulWidget {
  const FileList({Key? key}) : super(key: key);

  @override
  _FileListState createState() => _FileListState();
}

class _FileListState extends State<FileList> {
  @override
  void initState() {
    super.initState();
    controller = Get.put(FileListController());
  }

  late final controller;
  int _selectedIndex = 0;

  Widget _docsTagList(var context) {
    List<Widget> chips = [];

    // 전체 보기 칩
    Widget allChip = Container(
        margin: EdgeInsets.fromLTRB(16, 0, 5, 0),
        child: SLG_Chips.getFileChip(
          isChecked: (_selectedIndex == 0),
          label: '전체',
          onSelected: (bool selected) {
            setState(() {
              _selectedIndex = 0;
            });
          },
        ));

    chips.add(allChip);

    for (int i = 0; i < FileCategories.length; i++) {
      bool _isChecked = (_selectedIndex == i + 1);

      Widget choiceChip = Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: SLG_Chips.getFileChip(
          isChecked: _isChecked,
          label: FileCategories[i]['title'],
          onSelected: (bool selected) {
            setState(() {
              _selectedIndex = i + 1;
            });
          },
        ),
      );

      chips.add(choiceChip);
    }

    return SizedBox(
      height: 50,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: chips,
      ),
    );
  }

  List<Widget> _getSelectedFileWidgets(var data) {
    List<Widget> fileWidgets = [];

    // fileWidgets.add(PhotoFolder());

    for (var index = 0; index < data.length; index++) {
      final item = data[index];
      String category = FileCategories[_selectedIndex - 1]['title'];
      if (category == item.category)
        fileWidgets.add(
          UserFileCard(
            id: item.id,
            title: item.title,
            extension: item.extension,
            size: item.size,
            createdAt: item.createdAt,
            linkedSillog: item.linkedSillog,
          ),
        );
    }

    return fileWidgets;
  }

  @override
  Widget build(BuildContext context) {
    final dao = GetIt.instance<UserFileDao>();
    return Scaffold(
      appBar: CustomAppBar(title: 'sillog', color: SLG_COLOR, actions: [
        TextButton(
          onPressed: () {
            setState(() {
              controller.changeMode();
            });
          },
          child: Obx(
            () {
              return Text(
                controller.isSelectMode.value ? '취소' : '선택',
                style: TextStyle(color: SLG_COLOR),
              );
            },
          ),
        ),
      ]),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          StreamBuilder<List<UserFileData>>(
            stream: dao.streamUserFiles(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: _docsTagList(context),
                    ),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: _selectedIndex == 0
                            ? List.generate(data.length, (index) {
                                final item = data[index];

                                return UserFileCard(
                                    id: item.id,
                                    backgroundColor: Colors.white,
                                    title: item.title,
                                    extension: item.extension,
                                    size: item.size,
                                    createdAt: item.createdAt,
                                    linkedSillog: item.linkedSillog);
                              })
                            : _getSelectedFileWidgets(data),
                      ),
                    ),
                    SizedBox.shrink()
                  ],
                );
              } else {
                return _docsTagList(context);
              }
            },
          ),
          // Bottom Button
          Obx(() {
            return controller.isSelectMode.value
                ? SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SendButton(
                              onPressed: () {
                                Get.to(ShareScreen());
                              },
                              text: '보 내 기')),
                    ),
                  )
                : SizedBox.shrink();
          }),
          // FloatingAction BUTTON
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Obx(() {
                    return controller.isSelectMode.value
                        ? FileDeleteButton()
                        : FileAddButton();
                  })),
            ),
          ),
        ],
      ),
    );
  }
}


// SLIVER APPBAR

            // return CustomScrollView(
            //   slivers: [
            //     SliverAppBar(
            //       pinned: true,
            //       snap: true,
            //       floating: true,
            //       expandedHeight: 160.0,
            //       flexibleSpace: FlexibleSpaceBar(
            //         title: Text('Sliver app bar'),
            //       ),
            //     ),

            //     SliverGrid(
            //       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //         maxCrossAxisExtent: 200.0,
            //         mainAxisSpacing: 10.0,
            //         crossAxisSpacing: 10.0,
            //         childAspectRatio: 1 / 1,
            //       ),
            //       delegate: SliverChildBuilderDelegate(
            //         (context, index) {
            //           final item = data[index];

            //           return UserFileCard(
            //             title: item.title,
            //             extension: item.extension,
            //             size: item.size,
            //             createdAt: item.createdAt,
            //           );
            //         },
            //         childCount: data.length,
            //       ),
            //     )
            //   ],
            // );