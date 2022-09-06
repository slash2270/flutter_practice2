import 'dart:io';
import 'package:common_utils/common_utils.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

class VideoThumbnail extends StatefulWidget {
  const VideoThumbnail({Key? key}) : super(key: key);

  @override
  _VideoThumbnailState createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  File? _thumbnailFile;

  @override
  Widget build(BuildContext context) {
    Future<void> _getVideoThumbnail() async {
      Object? file;

      if (Platform.isMacOS) {
        final typeGroup =
        XTypeGroup(label: 'videos', extensions: ['mov', 'mp4']);
        XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);
        if (file != null) {
          _thumbnailFile = await VideoCompress.getFileThumbnail(file.path);
          setState(() {
            LogUtil.e(_thumbnailFile);
          });
        } else {
          return;
        }
      } else {
        final picker = ImagePicker();
        var pickedFile = await picker.pickVideo(source: ImageSource.gallery);
        File file = File(pickedFile!.path);
        if (file != null) {
          _thumbnailFile = await VideoCompress.getFileThumbnail(file.path);
          setState(() {
            LogUtil.e(_thumbnailFile);
          });
        } else {
          return;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('文件縮略圖')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: _getVideoThumbnail,
                child: const Text('取得文件縮略圖')),
            _buildThumbnail(),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    if (_thumbnailFile != null) {
      return Container(
        padding: const EdgeInsets.all(20.0),
        child: Image(image: FileImage(_thumbnailFile!)),
      );
    }
    return Container();
  }
}