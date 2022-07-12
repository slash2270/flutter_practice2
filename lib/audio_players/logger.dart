import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/audio_players/tab_wrapper.dart';
import 'btn.dart';

class LoggerTab extends StatefulWidget {
  const LoggerTab({Key? key}) : super(key: key);

  @override
  _LoggerTabState createState() => _LoggerTabState();
}

class _LoggerTabState extends State<LoggerTab> {
  static GlobalPlatformInterface get _logger => AudioPlayer.global;

  LogLevel currentLogLevel = _logger.logLevel;

  @override
  Widget build(BuildContext context) {
    return TabWrapper(
      children: [
        Text('日誌級別: $currentLogLevel'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _LogLevelButton()
          ],
        ),
      ],
    );
  }
  Widget _LogLevelButton(){
    return LogLevel.values.map((e) => Btn(
        txt: e.toString().replaceAll('日誌級別.', ''),
        onPressed: () async {
          await _logger.changeLogLevel(e);
          setState(() => currentLogLevel = _logger.logLevel);
        },
      ),
    ).toList()[0];
  }
}