import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers_platform_interface/api/player_mode.dart';
import 'package:audioplayers_platform_interface/api/release_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/audio_players/tab_wrapper.dart';
import 'package:flutter_practice2/audio_players/tgl.dart';
import 'package:flutter_practice2/audio_players/txt.dart';
import 'package:flutter_practice2/extension/extension.dart';

import 'btn.dart';

class ControlsTab extends StatefulWidget {
  final AudioPlayer player;

  const ControlsTab({Key? key, required this.player}) : super(key: key);

  @override
  State<ControlsTab> createState() => _ControlsTabState();
}

class _ControlsTabState extends State<ControlsTab> {
  String modalInputSeek = '';

  Future<void> update(Future<void> Function() fn) async {
    await fn();
    // update everyone who listens to "player"
    setState(() {});
  }

  Future<void> seekPercent(double percent) async {
    final duration = await widget.player.getDuration();
    if (duration == null) {
      toast('未能獲得按比例搜索的持續時間');
      return;
    }
    final position = duration * percent;
    seekDuration(position);
  }

  Future<void> seekDuration(Duration duration) async {
    update(() => widget.player.seek(duration));
  }

  @override
  Widget build(BuildContext context) {
    return TabWrapper(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Btn(txt: '暫停', onPressed: widget.player.pause),
            Btn(txt: '停止', onPressed: widget.player.stop),
            Btn(txt: '恢復', onPressed: widget.player.resume),
            Btn(txt: '發布', onPressed: widget.player.release),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('音量'),
            ...[0.0, 0.5, 1.0, 2.0].map((it) {
              return Btn(
                txt: it.toString(),
                onPressed: () => widget.player.setVolume(it),
              );
            }),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('速度'),
            ...[0.0, 0.5, 1.0, 2.0].map((it) {
              return Btn(
                txt: it.toString(),
                onPressed: () => widget.player.setPlaybackRate(it),
              );
            }),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('播放模式'),
            EnumTgl<PlayerMode>(
              options: PlayerMode.values,
              selected: widget.player.mode,
              onChange: (playerMode) {
                update(() => widget.player.setPlayerMode(playerMode));
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('發布模式'),
            EnumTgl<ReleaseMode>(
              options: ReleaseMode.values,
              selected: widget.player.releaseMode,
              onChange: (releaseMode) {
                update(() => widget.player.setReleaseMode(releaseMode));
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('尋找'),
            ...[0.0, 0.5, 1.0].map((it) {
              return Btn(
                txt: it.toString(),
                onPressed: () => seekPercent(it),
              );
            }),
            Btn(
              txt: '客製',
              onPressed: () async {
                dialog([
                  const Text('選擇要尋找的持續時間和單位'),
                  TxtBox(
                    value: modalInputSeek,
                    onChange: (it) => setState(() => modalInputSeek = it),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Btn(
                        txt: '毫',
                        onPressed: () {
                          Navigator.of(context).pop();
                          seekDuration(
                            Duration(
                              milliseconds: int.parse(modalInputSeek),
                            ),
                          );
                        },
                      ),
                      Btn(
                        txt: '秒',
                        onPressed: () {
                          Navigator.of(context).pop();
                          seekDuration(
                            Duration(
                              seconds: int.parse(modalInputSeek),
                            ),
                          );
                        },
                      ),
                      Btn(
                        txt: '%',
                        onPressed: () {
                          Navigator.of(context).pop();
                          seekPercent(double.parse(modalInputSeek));
                        },
                      ),
                      Btn(
                        txt: '取消',
                        onPressed: Navigator.of(context).pop,
                      ),
                    ],
                  ),
                ]);
              },
            ),
          ],
        ),
      ],
    );
  }
}