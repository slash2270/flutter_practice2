import 'package:flutter/material.dart';
import 'package:ota_update/ota_update.dart';

class OtaUpdateDemo extends StatefulWidget {
  const OtaUpdateDemo({Key? key}) : super(key: key);

  @override
  _OtaUpdateDemoState createState() => _OtaUpdateDemoState();
}

class _OtaUpdateDemoState extends State<OtaUpdateDemo> {
  late OtaEvent currentEvent;

  @override
  void initState() {
    super.initState();
    tryOtaUpdate();
  }

  /**
   * 狀態
      下載：
      下載階段事件的狀態
      事件值是下載進度百分比
      安裝：
      在觸發安裝意圖之前發送的事件狀態
      事件值為空
      已經運行錯誤：
      在上一次運行完成之前調用“執行”方法時發送
      事件值為空
      權限未授予錯誤：
      當用戶拒絕授予所需權限時發送
      事件值為空。
      下載錯誤
      下載崩潰時發送。
      校驗和錯誤（僅限安卓）
      如果計算的 SHA-256 校驗和與提供的（可選）值不匹配，則發送
      如果應驗證校驗和值，則發送，但校驗和計算失敗
      內部錯誤：
      在所有其他錯誤情況下發送
      事件值是潛在的錯誤消息
   */

  Future<void> tryOtaUpdate() async {
    try {
      currentEvent = OtaEvent(OtaStatus.DOWNLOADING, '開始下載');
      //鏈接包含來自 FLUTTER SDK 示例的 FLUTTER HELLO WORLD 的 APK
      OtaUpdate()
          .execute(
        'https://internal1.4q.sk/flutter_hello_world.apk',
        destinationFilename: 'flutter_hello_world.apk',
        //僅適用於 Android - 驗證文件校驗和的能力：
        sha256checksum: 'd6da28451a1e15cf7a75f2c3f151befad3b80ad0bb232ab15c20897e54f21478',
      )
          .listen(
            (OtaEvent event) {
          setState(() => currentEvent = event);
        },
      );
      // 忽略：避免沒有 on 子句的捕獲
    } catch (e) {
      print('OTA更新失敗。 細節: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ota Update Demo'),
        ),
        body: Center(
          child: currentEvent.value!.isNotEmpty ? Text('OTA 狀態:\n${currentEvent.status}\n${currentEvent.value}') : const Text('已下載完畢'),
        ),
      ),
    );
  }
}