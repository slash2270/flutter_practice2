import 'dart:io';

import 'package:flutter/material.dart';

/// 用於顯示圖像預覽的小部件
class ImagePreviews extends StatelessWidget {
  /// 顯示圖像的圖像路徑
  final List<String> imagePaths;

  /// 刪除圖像時的回調
  final Function(int)? onDelete;

  /// 創建一個用於預覽圖像的小部件。 [imagePaths] 不能為空
  /// 並且所有包含的路徑都必須是非空的。
  const ImagePreviews(this.imagePaths, {Key? key, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imagePaths.isEmpty) {
      return Container();
    }

    final imageWidgets = <Widget>[];
    for (var i = 0; i < imagePaths.length; i++) {
      imageWidgets.add(_ImagePreview(
        imagePaths[i],
        onDelete: onDelete != null ? () => onDelete!(i) : null,
      ));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: imageWidgets),
    );
  }
}

class _ImagePreview extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onDelete;

  const _ImagePreview(this.imagePath, {Key? key, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageFile = File(imagePath);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 200,
              maxHeight: 200,
            ),
            child: Image.file(imageFile),
          ),
          Positioned(
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: onDelete,
                  child: const Icon(Icons.delete)),
            ),
          ),
        ],
      ),
    );
  }
}