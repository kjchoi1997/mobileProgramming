import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FilePreview extends StatelessWidget {
  const FilePreview({
    Key? key,
    required this.extension,
    this.height,
    this.width,
  }) : super(key: key);

  final String extension;
  final double? height;
  final double? width;

  Widget _getImageAsset() {
    switch (extension) {
      case '.ppt':
        return Image.asset(
          'assets/image/file_logo/logo_ppt.png',
        );
      case '.pdf':
        return Image.asset(
          'assets/image/file_logo/logo_pdf.png',
        );
      case '.docx':
        return Image.asset(
          'assets/image/file_logo/logo_docx.png',
        );
      case '.doc':
        return Image.asset(
          'assets/image/file_logo/logo_docx.png',
        );
      case '.pptx':
        return Image.asset(
          'assets/image/file_logo/logo_pptx.png',
        );
      case 'folder':
        return Icon(Icons.folder);
      default:
        return Image.asset(
          'assets/image/logo.png',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return height == null
        ? _getImageAsset()
        : Container(
            height: height,
            width: width,
            child: _getImageAsset(),
          );
  }
}
