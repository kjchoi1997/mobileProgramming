import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sillog/FileManage/controller/file_list_controller.dart';
import 'package:sillog/home/components/slg_bottom_navigation_menu.dart';
import 'package:sillog/utils/utils.dart';
import 'package:sillog/widgets/buttons.dart';

import 'package:path/path.dart' as p;

class ShareScreen extends StatelessWidget {
  const ShareScreen({Key? key}) : super(key: key);

  List<Widget> getSelectedCard() {
    final controller = Get.put(FileListController());

    List<Widget> selectedLists = [];

    for (var key in controller.selectedFileList.keys) {
      Widget listTile = Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: ListTile(
          title: Text(controller.selectedFileList[key].name),
          trailing: GestureDetector(
            child: Icon(Icons.close, color: Colors.black),
            onTap: () {
              controller.cancelFile(controller.selectedFileList[key].id);
              if (controller.selectedFileList.keys.length == 0) {
                Get.back();
              }
            },
          ),
        ),
      );

      selectedLists.add(listTile);
    }
    return selectedLists;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FileListController());
    return Scaffold(
        appBar: AppBar(backgroundColor: APP_BG_COLOR, elevation: 0.0),
        bottomNavigationBar: SLGBottomNavigationMenu(ishome: false),
        body: Container(
          child: Stack(children: [
            Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: 50),
                    Container(
                        height: 40,
                        width: 40,
                        child: Image.asset('assets/image/logo.png')),
                    SizedBox(height: 13),
                    Text(
                      '해당 파일을 보내시겠습니까?',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
                Container(
                  height: 200,
                  child: Obx(
                    () {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: ListView(
                          children: getSelectedCard(),
                        ),
                      );
                    },
                  ),
                ),
                // CupertinoTextField(controller: textController),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomButton(
                  onPressed: () async {
                    List<String> fileLists = [];
                    var appDir = await getApplicationDocumentsDirectory();
                    controller.selectedFileList.forEach((key, value) {
                      fileLists.add(p.join(appDir.path, value.name));
                    });
                    await Share.shareFiles(fileLists);
                  },
                  text: '공 유 하 기'),
            ),
          ]),
        ));
  }
}
