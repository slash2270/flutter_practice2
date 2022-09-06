import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:platform/platform.dart';

/// 用於啟動意圖的示例應用程序。
class IntentPlusDemo extends StatelessWidget {
  const IntentPlusDemo({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intent Plus Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      routes: <String, WidgetBuilder>{
        ExplicitIntentsWidget.routeName: (BuildContext context) => const ExplicitIntentsWidget()
      },
    );
  }
}

/// 持有不同的意圖小部件.
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  void _createAlarm() {
    const intent = AndroidIntent(
      action: 'android.intent.action.SET_ALARM',
      arguments: <String, dynamic>{
        'android.intent.extra.alarm.DAYS': <int>[2, 3, 4, 5, 6],
        'android.intent.extra.alarm.HOUR': 21,
        'android.intent.extra.alarm.MINUTES': 30,
        'android.intent.extra.alarm.SKIP_UI': true,
        'android.intent.extra.alarm.MESSAGE': 'Create a Flutter app',
      },
    );
    intent.launch();
  }

  void _openExplicitIntentsView(BuildContext context) {
    Navigator.of(context).pushNamed(ExplicitIntentsWidget.routeName);
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (const LocalPlatform().isAndroid) {
      body = Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: _createAlarm,
              child: const Text('點擊此處設置鬧鐘\n工作日晚上 9:30。'),
            ),
            ElevatedButton(
              onPressed: _openChooser,
              child: const Text('點擊此處使用選擇器啟動 Intent'),
            ),
            ElevatedButton(
              onPressed: _sendBroadcast,
              child: const Text('點擊此處將 Intent 作為廣播發送'),
            ),
            ElevatedButton(
              onPressed: () => _openExplicitIntentsView(context),
              child: const Text('點擊此處測試顯式意圖'),
            ),
          ],
        ),
      );
    } else {
      body = const Text('此插件僅適用於 Android');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intent Plus Demo'),
      ),
      body: Center(child: body),
    );
  }

  void _openChooser() {
    const intent = AndroidIntent(
      action: 'android.intent.action.SEND',
      type: 'plain/text',
      data: 'text example',
    );
    intent.launchChooser('Chose an app');
  }

  void _sendBroadcast() {
    const intent = AndroidIntent(
      action: 'com.example.broadcast',
    );
    intent.sendBroadcast();
  }
}

/// 啟動特定 Android 活動的意圖。
class ExplicitIntentsWidget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ExplicitIntentsWidget(); // ignore: public_member_api_docs

  // ignore: public_member_api_docs
  static const String routeName = '/explicitIntents';

  void _openGoogleMapsStreetView() {
    final intent = AndroidIntent(
        action: 'action_view',
        data: Uri.encodeFull('google.streetview:cbll=46.414382,10.013988'),
        package: 'com.google.android.apps.maps');
    intent.launch();
  }

  void _displayMapInGoogleMaps({int zoomLevel = 12}) {
    final intent = AndroidIntent(
        action: 'action_view',
        data: Uri.encodeFull('geo:37.7749,-122.4194?z=$zoomLevel'),
        package: 'com.google.android.apps.maps');
    intent.launch();
  }

  void _launchTurnByTurnNavigationInGoogleMaps() {
    final intent = AndroidIntent(
        action: 'action_view',
        data: Uri.encodeFull(
            'google.navigation:q=Taronga+Zoo,+Sydney+Australia&avoid=tf'),
        package: 'com.google.android.apps.maps');
    intent.launch();
  }

  void _openLinkInGoogleChrome() {
    final intent = AndroidIntent(
        action: 'action_view',
        data: Uri.encodeFull('https://flutter.dev'),
        package: 'com.android.chrome');
    intent.launch();
  }

  void _startActivityInNewTask() {
    final intent = AndroidIntent(
      action: 'action_view',
      data: Uri.encodeFull('https://flutter.dev'),
      flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
    );
    intent.launch();
  }

  void _testExplicitIntentFallback() {
    final intent = AndroidIntent(
        action: 'action_view',
        data: Uri.encodeFull('https://flutter.dev'),
        package: 'com.android.chrome.implicit.fallback');
    intent.launch();
  }

  void _openLocationSettingsConfiguration() {
    const AndroidIntent intent = AndroidIntent(
      action: 'action_location_source_settings',
    );
    intent.launch();
  }

  void _openApplicationDetails() {
    const intent = AndroidIntent(
      action: 'action_application_details_settings',
      data: 'package:io.flutter.plugins.androidintentexample',
    );
    intent.launch();
  }

  void _openGmail() {
    const intent = AndroidIntent(
      action: 'android.intent.action.SEND',
      arguments: {'android.intent.extra.SUBJECT': 'I am the subject'},
      arrayArguments: {
        'android.intent.extra.EMAIL': ['eidac@me.com', 'overbom@mac.com'],
        'android.intent.extra.CC': ['john@app.com', 'user@app.com'],
        'android.intent.extra.BCC': ['liam@me.abc', 'abel@me.com'],
      },
      package: 'com.google.android.gm',
      type: 'message/rfc822',
    );
    intent.launch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('測試顯式意圖'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: _openGoogleMapsStreetView,
                child: const Text(
                    '點按此處可在 Google 街景中顯示全景\n圖像。'),
              ),
              ElevatedButton(
                onPressed: _displayMapInGoogleMaps,
                child: const Text('點擊此處可在 Google 地圖中顯示\na 地圖。'),
              ),
              ElevatedButton(
                onPressed: _launchTurnByTurnNavigationInGoogleMaps,
                child: const Text('點按此處可在 Google 地圖中啟動轉彎\n導航。'),
              ),
              ElevatedButton(
                onPressed: _openLinkInGoogleChrome,
                child: const Text('點擊此處在 Google Chrome 中打開鏈接。'),
              ),
              ElevatedButton(
                onPressed: _startActivityInNewTask,
                child: const Text('點擊此處開始新任務中的活動。'),
              ),
              ElevatedButton(
                onPressed: _testExplicitIntentFallback,
                child: const Text('點擊此處測試顯式意圖回退到隱式。'),
              ),
              ElevatedButton(
                onPressed: _openLocationSettingsConfiguration,
                child: const Text('點擊此處打開位置設置配置',),
              ),
              ElevatedButton(
                onPressed: _openApplicationDetails,
                child: const Text('點擊此處打開申請詳情',),
              ),
              ElevatedButton(
                onPressed: _openGmail,
                child: const Text('點擊此處打開帶有詳細信息的 gmail 應用程序',),
              ),
            ],
          ),
        ),
      ),
    );
  }
}