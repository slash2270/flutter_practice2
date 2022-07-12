import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/audio_players/sources.dart';
import 'package:flutter_practice2/audio_players/stream.dart';
import 'package:flutter_practice2/audio_players/tabs.dart';
import 'package:flutter_practice2/audio_players/tgl.dart';
import 'package:flutter_practice2/util/function_util.dart';

import 'audio_context.dart';
import 'controls.dart';
import 'logger.dart';

typedef OnError = void Function(Exception exception);

class AudioPlayerSWidget extends StatefulWidget {
  const AudioPlayerSWidget({Key? key}) : super(key: key);

  @override
  _AudioPlayerSWidgetState createState() => _AudioPlayerSWidgetState();
}

class _AudioPlayerSWidgetState extends State<AudioPlayerSWidget> {
  int selectedPlayerIdx = 0;
  List<AudioPlayer> players = List.generate(4, (_) => AudioPlayer());
  AudioPlayer get selectedPlayer => players[selectedPlayerIdx];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: FunctionUtil().initEdgeInsetsAll(8.0),
          child: Center(
            child: Tgl(
              options: const ['P1', 'P2', 'P3', 'P4'],
              selected: selectedPlayerIdx,
              onChange: (v) => setState(() => selectedPlayerIdx = v),
            ),
          ),
        ),
        Expanded(
            child: Tabs(
              tabs: {
                'Src': SourcesTab(player: selectedPlayer),
                'Ctrl': ControlsTab(player: selectedPlayer),
                'Stream': StreamsTab(player: selectedPlayer),
                'Ctx': AudioContextTab(player: selectedPlayer),
                'Log': const LoggerTab(),
              },
            ),
        ),
      ],
    );
  }
}