// 실록에 저장되는

import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class DocFile {
  DocFile.preAdd(this._beforePath)
      : _appPath = '',
        _category = '',
        _name = path.basenameWithoutExtension(_beforePath);

  String _name;
  String _beforePath;
  String _appPath;
  String _category;
  String linkedSillog = '';

  get extension => path.extension(this._beforePath);

  get category => _category;

  get nameWithExt => _name + extension;

  get name => _name;

  get beforePath => _beforePath;

  get appPath => _appPath;

  get size => File(_beforePath).lengthSync();

  void updateName(String newName) async {
    this._name = newName;
    var appDir = await getApplicationDocumentsDirectory();
    this._appPath = path.join(appDir.path, _name) + extension;
  }

  void updateCategory(String newCategory) {
    this._category = newCategory;
  }

  Future<int> getFileSize() async {
    return File(_beforePath).lengthSync();
  }

  @override
  String toString() {
    return "name: ${this._name}\npath: ${this._appPath}\ncategory: ${this._category}";
  }
}
