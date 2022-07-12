import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/audio_players/pad.dart';
import 'package:flutter_practice2/audio_players/player_widget.dart';
import 'package:flutter_practice2/audio_players/tab_wrapper.dart';
import 'package:flutter_practice2/extension/extension.dart';
import 'btn.dart';

class StreamsTab extends StatefulWidget {
  final AudioPlayer player;

  const StreamsTab({Key? key, required this.player}) : super(key: key);

  @override
  State<StreamsTab> createState() => _StreamsTabState();
}

class _StreamsTabState extends State<StreamsTab> {
  Duration? position, duration;
  late List<StreamSubscription> streams;

  Duration? streamDuration, streamPosition;
  PlayerState? state;

  @override
  void initState() {
    super.initState();
    streams = <StreamSubscription>[
      widget.player.onDurationChanged
          .listen((it) => setState(() => streamDuration = it)),
      widget.player.onPlayerStateChanged
          .listen((it) => setState(() => state = it)),
      widget.player.onPositionChanged
          .listen((it) => setState(() => streamPosition = it)),
      widget.player.onPlayerComplete.listen((it) => toast('播放器完成!')),
      widget.player.onSeekComplete.listen((it) => toast('尋找完成!')),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    for (var it in streams) {
      it.cancel();
    }
  }

  Future<void> getPosition() async {
    final position = await widget.player.getCurrentPosition();
    setState(() => this.position = position);
  }

  Future<void> getDuration() async {
    final duration = await widget.player.getDuration();
    setState(() => this.duration = duration);
  }

  @override
  Widget build(BuildContext context) {
    return TabWrapper(
      children: [
        Row(
          children: [
            Btn(
              txt: '獲取位置',
              onPressed: getPosition,
            ),
            const Pad(width: 8.0),
            Text(position?.toString() ?? '-'),
          ],
        ),
        Row(
          children: [
            Btn(
              txt: '獲取秒數',
              onPressed: getDuration,
            ),
            const Pad(width: 8.0),
            Text(duration?.toString() ?? '-'),
          ],
        ),
        const Divider(color: Colors.black),
        const Text('串流'),
        Text('串流秒數: $streamDuration'),
        Text('串流標誌: $streamPosition'),
        Text('串流狀態: $state'),
        const Divider(color: Colors.black),
        PlayerWidget(player: widget.player),
      ],
    );
  }
}