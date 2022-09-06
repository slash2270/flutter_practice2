import 'package:flustars/flustars.dart';

class TimeLogger {
  TimeLogger([this.tag = '']);

  String tag;
  int? start;

  void startRecorder() {
    start = DateTime.now().millisecondsSinceEpoch;
  }

  void logTime() {
    if (start == null) {
      LogUtil.e('start 為 null，必須先啟動 recorder。');
      return;
    }
    final diff = DateTime.now().millisecondsSinceEpoch - start!;
    if (tag != '') {
      LogUtil.e('$tag : $diff ms');
    } else {
      LogUtil.e('運行$diff ms');
    }
  }
}