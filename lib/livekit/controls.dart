import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'exts.dart';

class ControlsWidget extends StatefulWidget {
  final Room room;
  final LocalParticipant participant;
  const ControlsWidget(this.room, this.participant, {Key? key,}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ControlsWidgetState();
}

class _ControlsWidgetState extends State<ControlsWidget> {
  CameraPosition position = CameraPosition.front;

  @override
  void initState() {
    super.initState();
    participant.addListener(_onChange);
  }

  @override
  void dispose() {
    participant.removeListener(_onChange);
    super.dispose();
  }

  LocalParticipant get participant => widget.participant;

  void _onChange() {
    // trigger refresh
    setState(() {});
  }

  void _unpublishAll() async {
    final result = await context.showUnPublishDialog();
    if (result == true) await participant.unpublishAllTracks();
  }

  void _disableAudio() async {
    await participant.setMicrophoneEnabled(false);
  }

  Future<void> _enableAudio() async {
    await participant.setMicrophoneEnabled(true);
  }

  void _disableVideo() async {
    await participant.setCameraEnabled(false);
  }

  void _enableVideo() async {
    await participant.setCameraEnabled(true);
  }

  void _toggleCamera() async {
    //
    final track = participant.videoTracks.firstOrNull?.track;
    if (track == null) return;

    try {
      final newPosition = position.switched();
      await track.setCameraPosition(newPosition);
      setState(() {
        position = newPosition;
      });
    } catch (error) {
      LogUtil.e('無法重新啟動軌道: $error');
      return;
    }
  }

  void _enableScreenShare() async {
    if (WebRTC.platformIsDesktop) {
      try {
        final source = await showDialog<DesktopCapturerSource>(
          context: context,
          builder: (context) => ScreenSelectDialog(),
        );
        if (source == null) {
          LogUtil.e('取消屏幕共享');
          return;
        }
        LogUtil.e('桌面捕獲源: ${source.id}');
        var track = await LocalVideoTrack.createScreenShareTrack(
          ScreenShareCaptureOptions(
            sourceId: source.id,
            maxFrameRate: 15.0,
          ),
        );
        await participant.publishVideoTrack(track);
      } catch (e) {
        LogUtil.e('無法發布視頻: $e');
      }
      return;
    }
    if (WebRTC.platformIsAndroid) {
      // Android specific
      try {
        // Required for android screenshare.
        const androidConfig = FlutterBackgroundAndroidConfig(
          notificationTitle: '屏幕共享',
          notificationText: 'LiveKit 示例正在共享屏幕。',
          notificationImportance: AndroidNotificationImportance.Default,
          notificationIcon:
          AndroidResource(name: 'livekit_ic_launcher', defType: 'mipmap'),
        );
        await FlutterBackground.initialize(androidConfig: androidConfig);
        await FlutterBackground.enableBackgroundExecution();
      } catch (e) {
        LogUtil.e('無法發布視頻: $e');
      }
    }
    await participant.setScreenShareEnabled(true);
  }

  void _disableScreenShare() async {
    await participant.setScreenShareEnabled(false);
    if (Platform.isAndroid) {
      // Android specific
      try {
        //   await FlutterBackground.disableBackgroundExecution();
      } catch (error) {
        LogUtil.e('錯誤禁用屏幕共享: $error');
      }
    }
  }

  void _onTapDisconnect() async {
    final result = await context.showDisconnectDialog();
    if (result == true) await widget.room.disconnect();
  }

  void _onTapReconnect() async {
    final result = await context.showReconnectDialog();
    if (result == true) {
      try {
        await widget.room.reconnect();
        await context.showReconnectSuccessDialog();
      } catch (error) {
        await context.showErrorDialog(error);
      }
    }
  }

  void _onTapUpdateSubscribePermission() async {
    final result = await context.showSubscribePermissionDialog();
    if (result != null) {
      try {
        widget.room.localParticipant?.setTrackSubscriptionPermissions(
          allParticipantsAllowed: result,
        );
      } catch (error) {
        await context.showErrorDialog(error);
      }
    }
  }

  void _onTapSimulateScenario() async {
    final result = await context.showSimulateScenarioDialog();
    if (result != null) {
      LogUtil.e('$result');
      await widget.room.sendSimulateScenario(
        nodeFailure: result == SimulateScenarioResult.nodeFailure ? true : null,
        migration: result == SimulateScenarioResult.migration ? true : null,
        serverLeave: result == SimulateScenarioResult.serverLeave ? true : null,
      );
    }
  }

  void _onTapSendData() async {
    final result = await context.showSendDataDialog();
    if (result == true) {
      await widget.participant.publishData(
        utf8.encode('This is a sample data message'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 5,
        runSpacing: 5,
        children: [
          IconButton(
            onPressed: _unpublishAll,
            icon: const Icon(EvaIcons.closeCircleOutline),
            tooltip: '全部取消發布',
          ),
          if (participant.isMicrophoneEnabled())
            IconButton(
              onPressed: _disableAudio,
              icon: const Icon(EvaIcons.mic),
              tooltip: '靜音',
            )
          else
            IconButton(
              onPressed: _enableAudio,
              icon: const Icon(EvaIcons.micOff),
              tooltip: '取消靜音',
            ),
          if (participant.isCameraEnabled())
            IconButton(
              onPressed: _disableVideo,
              icon: const Icon(EvaIcons.video),
              tooltip: '靜音視頻',
            )
          else
            IconButton(
              onPressed: _enableVideo,
              icon: const Icon(EvaIcons.videoOff),
              tooltip: '取消靜音視頻',
            ),
          IconButton(
            icon: Icon(position == CameraPosition.back
                ? EvaIcons.camera
                : EvaIcons.person),
            onPressed: () => _toggleCamera(),
            tooltip: '切換相機',
          ),
          if (participant.isScreenShareEnabled())
            IconButton(
              icon: const Icon(EvaIcons.monitorOutline),
              onPressed: () => _disableScreenShare(),
              tooltip: '取消共享屏幕（實驗性）',
            )
          else
            IconButton(
              icon: const Icon(EvaIcons.monitor),
              onPressed: () => _enableScreenShare(),
              tooltip: '共享屏幕（實驗性）',
            ),
          IconButton(
            onPressed: _onTapDisconnect,
            icon: const Icon(EvaIcons.closeCircle),
            tooltip: '斷開',
          ),
          IconButton(
            onPressed: _onTapSendData,
            icon: const Icon(EvaIcons.paperPlane),
            tooltip: '發送演示數據',
          ),
          IconButton(
            onPressed: _onTapReconnect,
            icon: const Icon(EvaIcons.refresh),
            tooltip: '重新連接',
          ),
          IconButton(
            onPressed: _onTapUpdateSubscribePermission,
            icon: const Icon(EvaIcons.settings2),
            tooltip: '訂閱權限',
          ),
          IconButton(
            onPressed: _onTapSimulateScenario,
            icon: const Icon(EvaIcons.alertTriangle),
            tooltip: '模擬場景',
          ),
        ],
      ),
    );
  }
}