import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sillog/Registration/controller/reg_controller.dart';

import 'package:sillog/utils/utils.dart';
import 'dart:io';

class ImageListController extends GetxController {
  List<String> selectedImageList = Get.find<SillogController>().imageList;
  List<String> beforeImageList = [];

  Future<void> getImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        selectedImageList.add(pickedFile.path);

        update();
      } else {
        Get.snackbar('실록 알림', '이미지가 입력되지 않았어요 :(',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {}
  }

  Future<void> deleteFile(var file) async {
    print(selectedImageList.length);
    selectedImageList.remove(file);
    print(selectedImageList.length);

    update();
  }

  // 수정시 삭제된 이미지 삭제
  Future<void> deleteEditedImage() async {
    // 기존에 있던 파일과 새로운 파일을 비교함
    for (var beforeFile in beforeImageList) {
      // 만약 선택된 리스트에는 있지만 beforeFile에 없다면 삭제를 진행
      if (!selectedImageList.contains(beforeFile)) {
        print('- Edit : Delete $beforeFile');
        await File(beforeFile).delete();
      }
    }
  }

  Future<void> updateImgToDevice() async {
    log('Update img list', name: 'Register');

    for (var imageList in selectedImageList) {
      compressAndSaveFile(imageList);
    }
    log('Update img list Finished', name: 'Register');
  }

  Future<File> compressAndSaveFile(String filePath) async {
    File beforeFile = File(filePath);

    // Get Img Directory
    Directory appDir = await getApplicationDocumentsDirectory();
    String targetImgDir = join(appDir.path, 'img');
    String targetImg = join(targetImgDir, basename(filePath));

    // 만약 기존에 존재한다면 복사해서 저장하지 않음
    if (filePath == targetImg) return beforeFile;
    print('- COPY : $filePath to $targetImg');

    new Directory(targetImgDir).create(recursive: true);

    String ext = extension(filePath).substring(1);

    CompressFormat? format;
    if (ext == 'png')
      format = CompressFormat.png;
    else if (ext == 'jpeg' || ext == 'jpg')
      format = CompressFormat.jpeg;
    else if (ext == 'webp')
      format = CompressFormat.webp;
    else if (ext == 'heic') format = CompressFormat.heic;
    // enum CompressFormat { jpeg, png, heic, webp }
    if (format != null) {
      // Create output file path
      File? result = await FlutterImageCompress.compressAndGetFile(
          filePath, targetImg,
          quality: 50, format: format);
      print(beforeFile.lengthSync());
      print(result!.lengthSync());

      return result;
    } else {
      print('ERROR : FILE COMPRESS ERROR');
      await File(filePath).copy(targetImgDir);

      return beforeFile;
    }
  }
}
