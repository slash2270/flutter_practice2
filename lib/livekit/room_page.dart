// import 'dart:convert';
// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:flutter_practice2/livekit/exts.dart';
// import 'package:flutter_practice2/livekit/participant.dart';
// import 'package:flutter_practice2/livekit/participant_info.dart';
// import 'package:livekit_client/livekit_client.dart';
// import '../az_listview/common/index.dart';
// import 'controls.dart';
//
// class RoomPage extends StatefulWidget {
//   final Room room;
//   final EventsListener<RoomEvent> listener;
//
//   const RoomPage(this.room, this.listener, {Key? key,}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _RoomPageState();
// }
//
// class _RoomPageState extends State<RoomPage> {
//   List<ParticipantTrack> participantTracks = [];
//   EventsListener<RoomEvent> get _listener => widget.listener;
//   bool get fastConnection => widget.room.engine.fastConnectOptions != null;
//
//   @override
//   void initState() {
//     super.initState();
//     widget.room.addListener(_onRoomDidUpdate);
//     _setUpListeners();
//     _sortParticipants();
//     WidgetsBindingCompatible.instance?.addPostFrameCallback((_) {
//       if (!fastConnection) {
//         _askPublish();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     // 總是配置監聽器
//     (() async {
//       widget.room.removeListener(_onRoomDidUpdate);
//       await _listener.dispose();
//       await widget.room.dispose();
//     })();
//     super.dispose();
//   }
//
//   void _setUpListeners() => _listener
//     ..on<RoomDisconnectedEvent>((_) async {
//       WidgetsBindingCompatible.instance
//           ?.addPostFrameCallback((timeStamp) => Navigator.pop(context));
//     })
//     ..on<LocalTrackPublishedEvent>((_) => _sortParticipants())
//     ..on<LocalTrackUnpublishedEvent>((_) => _sortParticipants())
//     ..on<DataReceivedEvent>((event) {
//       String decoded = '解碼失敗';
//       try {
//         decoded = utf8.decode(event.data);
//       } catch (_) {
//         LogUtil.e('解碼失敗: $_');
//       }
//       context.showDataReceivedDialog(decoded);
//     });
//
//   void _askPublish() async {
//     final result = await context.showPublishDialog();
//     if (result != true) return;
//     // video will fail when running in ios simulator
//     try {
//       await widget.room.localParticipant?.setCameraEnabled(true);
//     } catch (error) {
//       LogUtil.e('無法發布視頻: $error');
//       await context.showErrorDialog(error);
//     }
//     try {
//       await widget.room.localParticipant?.setMicrophoneEnabled(true);
//     } catch (error) {
//       LogUtil.e('無法發布音頻: $error');
//       await context.showErrorDialog(error);
//     }
//   }
//
//   void _onRoomDidUpdate() {
//     _sortParticipants();
//   }
//
//   void _sortParticipants() {
//     List<ParticipantTrack> userMediaTracks = [];
//     List<ParticipantTrack> screenTracks = [];
//     for (var participant in widget.room.participants.values) {
//       for (var t in participant.videoTracks) {
//         if (t.isScreenShare) {
//           screenTracks.add(ParticipantTrack(
//             participant: participant,
//             videoTrack: t.track,
//             isScreenShare: true,
//           ));
//         } else {
//           userMediaTracks.add(ParticipantTrack(
//             participant: participant,
//             videoTrack: t.track,
//             isScreenShare: false,
//           ));
//         }
//       }
//     }
//     // 為網格排序揚聲器
//     userMediaTracks.sort((a, b) {
//       // 最響亮的揚聲器
//       if (a.participant.isSpeaking && b.participant.isSpeaking) {
//         if (a.participant.audioLevel > b.participant.audioLevel) {
//           return -1;
//         } else {
//           return 1;
//         }
//       }
//
//       // 最後一次發言是在
//       final aSpokeAt = a.participant.lastSpokeAt?.millisecondsSinceEpoch ?? 0;
//       final bSpokeAt = b.participant.lastSpokeAt?.millisecondsSinceEpoch ?? 0;
//
//       if (aSpokeAt != bSpokeAt) {
//         return aSpokeAt > bSpokeAt ? -1 : 1;
//       }
//
//       // 視頻開
//       if (a.participant.hasVideo != b.participant.hasVideo) {
//         return a.participant.hasVideo ? -1 : 1;
//       }
//
//       // 加入時間
//       return a.participant.joinedAt.millisecondsSinceEpoch - b.participant.joinedAt.millisecondsSinceEpoch;
//     });
//
//     final localParticipantTracks = widget.room.localParticipant?.videoTracks;
//     if (localParticipantTracks != null) {
//       for (var t in localParticipantTracks) {
//         if (t.isScreenShare) {
//           screenTracks.add(ParticipantTrack(
//             participant: widget.room.localParticipant!,
//             videoTrack: t.track,
//             isScreenShare: true,
//           ));
//         } else {
//           userMediaTracks.add(ParticipantTrack(
//             participant: widget.room.localParticipant!,
//             videoTrack: t.track,
//             isScreenShare: false,
//           ));
//         }
//       }
//     }
//     setState(() {
//       participantTracks = [...screenTracks, ...userMediaTracks];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     body: Column(
//       children: [
//         Expanded(
//             child: participantTracks.isNotEmpty
//                 ? ParticipantWidget.widgetFor(participantTracks.first)
//                 : Container()),
//         SizedBox(
//           height: 100,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: math.max(0, participantTracks.length - 1),
//             itemBuilder: (BuildContext context, int index) => SizedBox(
//               width: 100,
//               height: 100,
//               child:
//               ParticipantWidget.widgetFor(participantTracks[index + 1]),
//             ),
//           ),
//         ),
//         if (widget.room.localParticipant != null)
//           SafeArea(
//             top: false,
//             child:
//             ControlsWidget(widget.room, widget.room.localParticipant!),
//           ),
//       ],
//     ),
//   );
// }