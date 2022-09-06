import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/video_trimmer/video_trimmer_view.dart';

class VideoTrimmerDemo extends StatelessWidget {
  const VideoTrimmerDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Trimmer Demo"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("加載視頻"),
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.video,
              allowCompression: true,
            );
            if (result != null) {
              File file = File(result.files.single.path!);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return VideoTrimmerView(file);
                }),
              );
            }
          },
        ),
      ),
    );
  }
}