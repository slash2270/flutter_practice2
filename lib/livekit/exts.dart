import 'package:flutter/material.dart';

extension LKExampleExt on BuildContext {
  Future<bool?> showPublishDialog() => showDialog<bool>(
    context: this,
    builder: (ctx) => AlertDialog(
      title: const Text('發布'),
      content: const Text('你想發布你的相機和麥克風嗎?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('否'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('是'),
        ),
      ],
    ),
  );

  Future<bool?> showUnPublishDialog() => showDialog<bool>(
    context: this,
    builder: (ctx) => AlertDialog(
      title: const Text('取消發布'),
      content:
      const Text('您想取消發布您的相機和麥克風嗎?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('否'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('是'),
        ),
      ],
    ),
  );

  Future<void> showErrorDialog(dynamic exception) => showDialog<void>(
    context: this,
    builder: (ctx) => AlertDialog(
      title: const Text('錯誤'),
      content: Text(exception.toString()),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('確定'),
        )
      ],
    ),
  );

  Future<bool?> showDisconnectDialog() => showDialog<bool>(
    context: this,
    builder: (ctx) => AlertDialog(
      title: const Text('斷開'),
      content: const Text('你確定斷開連接嗎？'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('取消連接'),
        ),
      ],
    ),
  );

  Future<bool?> showReconnectDialog() => showDialog<bool>(
    context: this,
    builder: (ctx) => AlertDialog(
      title: const Text('重新連接'),
      content: const Text('這將強制重新連接'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('重新連接'),
        ),
      ],
    ),
  );

  Future<void> showReconnectSuccessDialog() => showDialog<void>(
    context: this,
    builder: (ctx) => AlertDialog(
      title: const Text('重新連接'),
      content: const Text('重新連接成功。'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('確定'),
        ),
      ],
    ),
  );

  Future<bool?> showSendDataDialog() => showDialog<bool>(
    context: this,
    builder: (ctx) => AlertDialog(
      title: const Text('發送數據'),
      content: const Text('這將向房間中的所有參與者發送樣本數據'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('發送'),
        ),
      ],
    ),
  );

  Future<bool?> showDataReceivedDialog(String data) => showDialog<bool>(
    context: this,
    builder: (ctx) => AlertDialog(
      title: const Text('接收數據'),
      content: Text(data),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('確定'),
        ),
      ],
    ),
  );

  Future<bool?> showSubscribePermissionDialog() => showDialog<bool>(
    context: this,
    builder: (ctx) => AlertDialog(
      title: const Text('允許訂閱'),
      content: const Text('允許所有參與者訂閱本地參與者發布的曲目?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('否'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('是'),
        ),
      ],
    ),
  );

  Future<SimulateScenarioResult?> showSimulateScenarioDialog() =>
      showDialog<SimulateScenarioResult>(
        context: this,
        builder: (ctx) => SimpleDialog(
          title: const Text('模擬場景'),
          children: SimulateScenarioResult.values
              .map((e) => SimpleDialogOption(
            child: Text(e.name),
            onPressed: () => Navigator.pop(ctx, e),
          ))
              .toList(),
        ),
      );
}

enum SimulateScenarioResult {
  nodeFailure,
  migration,
  serverLeave,
  clear,
}