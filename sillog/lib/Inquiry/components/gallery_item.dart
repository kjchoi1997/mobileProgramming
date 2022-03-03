import 'dart:io';

import 'package:flutter/widgets.dart';

class GalleryItem {
  GalleryItem({
    required this.id,
    required this.resource,
  });

  final String id;
  final String resource;
}

class GalleryItemThumbnail extends StatelessWidget {
  const GalleryItemThumbnail({
    Key? key,
    required this.galleryItem,
    required this.onTap,
  }) : super(key: key);

  final GalleryItem galleryItem;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: galleryItem.id + galleryItem.resource,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Image.file(File(galleryItem.resource), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
