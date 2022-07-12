import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class SharePlusWidget extends StatefulWidget {
  const SharePlusWidget({Key? key}) : super(key: key);

  @override
  SharePlusWidgetState createState() => SharePlusWidgetState();
}

class SharePlusWidgetState extends State<SharePlusWidget> {
  String text = '';
  String subject = '';
  List<String> imagePaths = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                      labelText: '分享文字：',
                      hintText: '輸入一些文字和/或分享鏈接',
                    ),
                    maxLines: 2,
                    onChanged: (String value) => setState(() {
                      text = value;
                    }),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: '分享主題：',
                      hintText: '輸入分享主題（可選)',
                    ),
                    maxLines: 2,
                    onChanged: (String value) => setState(() {
                      subject = value;
                    }),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 12.0)),
                  ImagePreviews(imagePaths, onDelete: _onDeleteImage),
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('加入圖像'),
                    onTap: () async {
                      final imagePicker = ImagePicker();
                      final pickedFile = await imagePicker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedFile != null) {
                        setState(() {
                          imagePaths.add(pickedFile.path);
                        });
                      }
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: 12.0)),
                  Builder(
                    builder: (BuildContext context) {
                      return ElevatedButton(
                        onPressed: text.isEmpty && imagePaths.isEmpty
                            ? null
                            : () => _onShare(context),
                        child: const Text('分享'),
                      );
                    },
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 12.0)),
                  Builder(
                    builder: (BuildContext context) {
                      return ElevatedButton(
                        onPressed: text.isEmpty && imagePaths.isEmpty
                            ? null
                            : () => _onShareWithResult(context),
                        child: const Text('分享結果'),
                      );
                    },
                  ),
                ],
              ),
    );
  }

  void _onDeleteImage(int position) {
    setState(() {
      imagePaths.removeAt(position);
    });
  }

  void _onShare(BuildContext context) async {
    // 構建器用於立即檢索上下文
    // 圍繞 ElevatedButton。
    //
    // 上下文的 `findRenderObject` 返回第一個
    // 不在其後代樹中渲染對象
    // 一個 RenderObjectWidget。 ElevatedButton 的 RenderObject
    // 在構建後有它的位置和大小。
    final box = context.findRenderObject() as RenderBox?;

    if (imagePaths.isNotEmpty) {
      await Share.shareFiles(imagePaths,
          text: text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }

  void _onShareWithResult(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    ShareResult result;
    if (imagePaths.isNotEmpty) {
      result = await Share.shareFilesWithResult(imagePaths,
          text: text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      result = await Share.shareWithResult(text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("分享結果: ${result.status}"),
    ));
  }
}

/// 用於顯示圖像預覽的小部件
class ImagePreviews extends StatelessWidget {
  /// 顯示圖片的圖片路徑
  final List<String> imagePaths;

  /// 刪除圖像時的回調
  final Function(int) onDelete;

  /// 創建一個用於預覽圖像的小部件。 [imagePaths] 不能為空
  /// 並且所有包含的路徑都必須是非空的。
  const ImagePreviews(this.imagePaths, {Key? key, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imagePaths.isEmpty) {
      return Container();
    }

    final imageWidgets = <Widget>[];
    for (var i = 0; i < imagePaths.length; i++) {
      imageWidgets.add(_ImagePreview(
        imagePaths[i],
        onDelete: onDelete,
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
  final Function(int) onDelete;
  const _ImagePreview(this.imagePath, {Key? key, required this.onDelete}) : super(key: key);

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
                  onPressed:(){
                    onDelete;
                  },
                  child: const Icon(Icons.delete)),
            ),
          ),
        ],
      ),
    );
  }
}