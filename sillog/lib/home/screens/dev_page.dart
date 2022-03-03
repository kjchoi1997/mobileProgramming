import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sillog/FileManage/file_add_btn.dart';
import 'package:sillog/FileManage/screens/file_main.dart';
import 'package:sillog/data/model/model.dart';
import 'package:sillog/FileManage/screens/add_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sillog/home/components/sns_login_btn.dart';
import 'package:sillog/home/screens/login_page.dart';

class DevButton extends StatelessWidget {
  const DevButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SSOLoginBtn(
      onPressed: () => Get.to(() => DevPage()),
      icon: Icon(Icons.developer_board),
      text: 'DevPage',
    );
  }
}

class DevPage extends StatefulWidget {
  const DevPage({Key? key}) : super(key: key);

  @override
  _DevPageState createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  _getAppDir() async {
    var appDir = await getApplicationDocumentsDirectory();
    print(appDir.path);
    setState(() {
      text = appDir.path;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAppDir();
  }

  String text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('dev'),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Column(
                children: [
                  Text('Results'),
                  // Text('${Get.arguments}'),
                  Text('$text'),
                ],
              ),
            ),
          ),
          InkWell(
            child: Card(
              child: ListTile(
                leading: Icon(Icons.document_scanner),
                title: Text('파일 추가'),
              ),
            ),
            onTap: () async {
              Get.to(() => FileAddPage());
            },
          ),
          InkWell(
            child: Card(
              child: ListTile(
                leading: Icon(Icons.document_scanner),
                title: Text('파일 추가'),
              ),
            ),
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();
              if (result != null) {
                // File file = File(result.files.single.path!);
                await Get.to(FileDetailPage(),
                    arguments: DocFile.preAdd(result.files.single.path!));
              } else {
                // User canceled the picker
                Get.snackbar('실록 알림', '파일이 선택되지 않았어요 :(',
                    snackPosition: SnackPosition.TOP);
              }
            },
          ),
          InkWell(
            child: Card(
              child: ListTile(
                leading: Icon(Icons.document_scanner),
                title: Text('파일 메인뷰'),
              ),
            ),
            onTap: () async {
              await Get.to(FileList());
            },
          ),
          InkWell(
            child: Card(
              child: ListTile(
                leading: Icon(Icons.document_scanner),
                title: Text('PDF'),
              ),
            ),
            onTap: () async {
              await Get.to(LoginPage());
            },
          ),
        ],
      ),
    );
  }
}
