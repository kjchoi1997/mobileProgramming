import 'package:get/get.dart';
import 'package:sillog/FileManage/controller/file_controller.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';
import 'package:sillog/data/model/model.dart';
import 'package:file_picker/file_picker.dart';

class FileAddListController extends GetxController {
  var selectedFiles = <DocFile>[].obs;
  var selectedFileNames = Get.find<SillogController>().fileList;

  Future<FilePickerResult?> getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['ppt', 'pdf', 'doc', 'pptx', 'hwp'],
    );

    return result;
  }

  setLinkedSillog(String sillogId) {
    for (var file in selectedFiles) {
      file.linkedSillog = sillogId;
    }
  }

  Future<void> addFile(DocFile file) async {
    checkDup(file);
    selectedFiles.add(file);
    selectedFileNames.add(file.nameWithExt);
  }

  Future<void> deleteFile(DocFile file) async {
    selectedFiles.remove(file);
    selectedFileNames.remove(file.nameWithExt);
  }

  bool checkDup(DocFile target) {
    for (DocFile file in selectedFiles) {
      if (target.beforePath == file.beforePath) {
        print('file' + file.beforePath);
        print('target' + target.beforePath);
        selectedFiles.remove(file);
        selectedFileNames.remove(file.nameWithExt);

        return true;
      }
    }
    return false;
  }

  Future<void> updateFile() async {
    for (DocFile value in selectedFiles) {
      print('UPDATE : ' + value.appPath);
      await FileController.copyFileToAppdir(value);
      await FileController.updateDB(value);
    }
    selectedFiles = <DocFile>[].obs;
    selectedFileNames = [];
  }
}
