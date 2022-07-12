import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/audio_players/tab_wrapper.dart';
import 'package:flutter_practice2/audio_players/tabs.dart';

import 'btn.dart';
import 'cbx.dart';

class AudioContextTab extends StatefulWidget {
  final AudioPlayer player;

  const AudioContextTab({Key? key, required this.player}) : super(key: key);

  @override
  _AudioContextTabState createState() => _AudioContextTabState();
}

class _AudioContextTabState extends State<AudioContextTab> {
  static GlobalPlatformInterface get _global => AudioPlayer.global;

  AudioContextConfig config = AudioContextConfig();

  @override
  Widget build(BuildContext context) {
    return TabWrapper(
      children: [
        const Text('音頻上下文'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Btn(
              txt: '重來',
              onPressed: () => updateConfig(AudioContextConfig()),
            ),
            Btn(
              txt: '全域',
              onPressed: () => _global.setGlobalAudioContext(config.build()),
            ),
            Btn(
              txt: '本機',
              onPressed: () => widget.player.setAudioContext(config.build()),
            )
          ],
        ),
        SizedBox(
          height: 500,
          child: Tabs(
            tabs: {
              '通用標誌': _genericTab(),
              '安卓': _androidTab(),
              '蘋果': _iosTab(),
            },
          ),
        ),
      ],
    );
  }

  void updateConfig(AudioContextConfig newConfig) {
    setState(() => config = newConfig);
  }

  Widget _genericTab() {
    return Column(
      children: [
        Cbx(
          '強制揚聲器',
          config.forceSpeaker,
              (v) => updateConfig(config.copy(forceSpeaker: v)),
        ),
        Cbx(
          '鴨子音頻',
          config.duckAudio,
              (v) => updateConfig(config.copy(duckAudio: v)),
        ),
        Cbx(
          '尊重沉默',
          config.respectSilence,
              (v) => updateConfig(config.copy(respectSilence: v)),
        ),
        Cbx(
          '保持清醒',
          config.stayAwake,
              (v) => updateConfig(config.copy(stayAwake: v)),
        ),
      ],
    );
  }

  Widget _androidTab() {
    final a = config.buildAndroid();
    return Column(
      children: [
        Text('免提電話是否打開: ${a.isSpeakerphoneOn}'),
        Text('保持清醒: ${a.stayAwake}'),
        Text('內容類型: ${a.contentType}'),
        Text('使用類型: ${a.usageType}'),
        Text('音頻焦點: ${a.audioFocus}'),
      ],
    );
  }

  Widget _iosTab() {
    final i = config.buildIOS();
    return Column(
      children: [
        Text('默認到揚聲器: ${i.defaultToSpeaker}'),
        Text('類別: ${i.category}'),
        Text('選項: ${i.options}'),
      ],
    );
  }
}