import 'package:get/get.dart';
import 'package:sillog/FileManage/controller/file_controller.dart';

class SelectedFile {
  const SelectedFile({required this.id, required this.name});
  final int id;
  final String name;
}

class FileListController extends GetxController {
  FileListController();

  var selectedFileList = {}.obs;
  var isSelectMode = false.obs;

  bool changeMode() {
    isSelectMode.value = !isSelectMode.value;
    selectedFileList.clear();
    update();
    return isSelectMode.value;
  }

  bool isSelected(int index) {
    return selectedFileList.keys.contains(index);
  }

  // 파일을 선택
  void selectFile(int id, String name) {
    selectedFileList.keys.contains(id)
        ? selectedFileList.remove(id)
        : selectedFileList[id] = SelectedFile(
            id: id,
            name: name,
          );

    if (selectedFileList.keys.length == 0) {
      isSelectMode.value = false;
    }
  }

  // 파일을 선택 해제
  void cancelFile(int id) {
    selectedFileList.remove(id);
    update();
  }

  // 선택한 파일을 공유
  void shareFiles() {}

  // 선택한 파일을 삭제
  void deleteFiles() {
    selectedFileList.forEach((key, value) {
      // db에서 파일을 제거
      FileController.deleteFile(key, value);
      // 실록에서 파일만을 선택해제
    });
  }
}
