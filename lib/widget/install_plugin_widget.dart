/*import 'package:flutter/material.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:permission_handler/permission_handler.dart';

class InstallPluginWidget extends StatefulWidget {
  @override
  _InstallPluginWidgetState createState() => _InstallPluginWidgetState();
}

class _InstallPluginWidgetState extends State<InstallPluginWidget> {
  String _appUrl = '';
  String _apkFilePath = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          decoration: const InputDecoration(
              hintText: 'apk file path to install. Like /storage/emulated/0/demo/update.apk'),
          onChanged: (path) => _apkFilePath = path,
        ),
        FlatButton(
            onPressed: () {
              onClickInstallApk();
            },
            child: const Text('install')),
        TextField(
          decoration:
          const InputDecoration(hintText: 'URL for app store to launch'),
          onChanged: (url) => _appUrl = url,
        ),
        FlatButton(
            onPressed: () => onClickGotoAppStore(_appUrl),
            child: const Text('gotoAppStore'))
      ],
    );
  }

  void onClickInstallApk() async {
    if (_apkFilePath.isEmpty) {
      print('make sure the apk file is set');
      return;
    }
    if (Permission.storage == PermissionStatus.granted) {
      InstallPlugin.installApk(_apkFilePath, 'com.zaihui.installpluginexample')
          .then((result) {
        print('install apk $result');
      }).catchError((error) {
        print('install apk error: $error');
      });
    } else {
      print('Permission request fail!');
    }
  }

  void onClickGotoAppStore(String url) {
    url = url.isEmpty
        ? 'https://itunes.apple.com/cn/app/%E5%86%8D%E6%83%A0%E5%90%88%E4%BC%99%E4%BA%BA/id1375433239?l=zh&ls=1&mt=8'
        : url;
    InstallPlugin.gotoAppStore(url);
  }
}*/