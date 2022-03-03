import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sillog/data/model/doc_model.dart';
import 'package:path/path.dart' as p;
import 'package:sillog/data/provider/database.dart';
import 'package:sillog/data/provider/filedb.dart';
import 'package:moor/moor.dart' as moor;
import 'dart:developer' as dev;

class FileController {
  const FileController();

  static Future<void> copyFileToAppdir(DocFile file) async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      String newPath = p.join(dir.path, file.nameWithExt);
      await File(file.beforePath).copy(newPath);

      print("Success");
    } catch (e) {
      throw Exception('Error parsing asset _file!');
    }
  }

  static void updateFileInst(
    DocFile _file,
    String title,
    String category,
  ) {
    _file.updateName(title);
    _file.updateCategory(category);
  }

  static Future<void> updateDB(DocFile file) async {
    final dao = GetIt.instance<UserFileDao>();

    await dao.insertUserFile(
      UserFileCompanion(
        title: moor.Value(file.name),
        category: moor.Value(file.category),
        beforePath: moor.Value(file.beforePath),
        appPath: moor.Value(file.appPath),
        size: moor.Value(file.size),
        extension: moor.Value(file.extension),
        linkedSillog: moor.Value(file.linkedSillog),
      ),
    );
  }

  static Future<void> deleteFile(int id, String appPath) async {
    try {
      final file = File(appPath);
      bool isExist = file.existsSync();

      // 파일 삭제
      if (isExist) await file.delete();
      final dao = GetIt.instance<UserFileDao>();

      // DB 삭제
      dao.deleteUserFileWithID(id);

      // TODO: 서버에서 제거

    } catch (e) {
      dev.log('[Error] $e', name: 'file_controller');
      return;
    }
  }
}
