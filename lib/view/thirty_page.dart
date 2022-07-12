import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/download/download_demo.dart';

class ThirtyPage extends StatefulWidget {
  const ThirtyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ThirtyPageState();
  }
}

class ThirtyPageState extends State<ThirtyPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 一个不需要GlobalKey就可以openDrawer的AppBar
      appBar: AppBar(
        title: const Text('Thirty Page'),
        centerTitle: true,
        actions: <Widget>[
          if (Platform.isIOS) PopupMenuButton<Function>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () => exit(0),
                child: const ListTile(
                  title: Text('模擬後台應用', style: TextStyle(fontSize: 15)),
                ),
              ),
            ],
          ),
        ],
      ),
      body: DownloadDemo(platform: TargetPlatform.android),
      resizeToAvoidBottomInset: false,
    );
  }

}