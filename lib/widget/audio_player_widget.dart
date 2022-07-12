// @dart = 2.9

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayer/audioplayer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:http/http.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

typedef OnError = void Function(Exception exception);

enum PlayerState { stopped, playing, paused }

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget ({Key key}) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {

  Duration _duration;
  Duration _position;

  AudioPlayer _audioPlayer;

  String _localFilePath;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;
  get durationText => _duration != null ? _duration.toString().split('.').first : '';
  get positionText => _position != null ? _position.toString().split('.').first : '';

  bool _isMuted = false;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  FunctionUtil _functionUtil;

  final kUrl = "https://www.mediacollege.com/downloads/sound-effects/nature/forest/rainforest-ambient.mp3";

  @override
  void initState() {
    super.initState();
    _functionUtil = FunctionUtil();
    _initAudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    super.dispose();
  }

  void _initAudioPlayer() {
    _audioPlayer = AudioPlayer();
    _positionSubscription = _audioPlayer.onAudioPositionChanged.listen((p) => setState(() => _position = p));
    _audioPlayerStateSubscription = _audioPlayer.onPlayerStateChanged.listen((s) {
          if (s == AudioPlayerState.PLAYING) {
            setState(() => _duration = _audioPlayer.duration);
          } else if (s == AudioPlayerState.STOPPED) {
            _onComplete();
            setState(() {
              _position = _duration;
            });
          }
        }, onError: (msg) {
          setState(() {
            playerState = PlayerState.stopped;
            _duration = const Duration(seconds: 0);
            _position = const Duration(seconds: 0);
          });
        });
  }

  Future _play() async {
    await _audioPlayer.play(kUrl);
    setState(() {
      playerState = PlayerState.playing;
    });
  }

  Future _playLocal() async {
    await _audioPlayer.play(_localFilePath, isLocal: true);
    setState(() => playerState = PlayerState.playing);
  }

  Future _pause() async {
    await _audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

  Future _stop() async {
    await _audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      _position = const Duration();
    });
  }

  Future _mute(bool muted) async {
    await _audioPlayer.mute(muted);
    setState(() {
      _isMuted = muted;
    });
  }

  void _onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }
  
  Future<Uint8List> _loadFileBytes(String url, {OnError onError}) async {
    Uint8List bytes;
    try {
      bytes = await readBytes(Uri.parse(url));
    } on ClientException {
      rethrow;
    }
    return bytes;
  }

  Future _loadFile() async {
    Directory appDocDir = await getTemporaryDirectory();
    String savePath = "${appDocDir.path}/temp.mp4";
    await Dio().download(kUrl, savePath);
    await ImageGallerySaver.saveFile(savePath);
    setState(() {
      _localFilePath = savePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('AudioPlayer',
              style: textTheme.headline4,
            ),
            Material(child: _buildPlayer()),
            if (!kIsWeb)
              _localFilePath != null ? Text(_localFilePath) : Container(),
            if (!kIsWeb)
              Padding(
                padding: _functionUtil.initEdgeInsetsAll(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: () => _loadFile(),
                      child: _functionUtil.initText('下載'),
                    ),
                    if (_localFilePath != null)
                      RaisedButton(
                        onPressed: () => _playLocal(),
                        child: _functionUtil.initText('本機播放'),
                      ),
                  ],
                ),
              ),
          ],
        ),
    );
  }

  Widget _buildPlayer() => Container(
    padding: _functionUtil.initEdgeInsetsAll(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
            onPressed: isPlaying ? null : () => _play(),
            iconSize: 64.0,
            icon: _functionUtil.initIcon(Icons.play_arrow),
            color: Constants.colorCyan,
          ),
          IconButton(
            onPressed: isPlaying ? () => _pause() : null,
            iconSize: 64.0,
            icon: _functionUtil.initIcon(Icons.pause),
            color: Constants.colorCyan,
          ),
          IconButton(
            onPressed: isPlaying || isPaused ? () => _stop() : null,
            iconSize: 64.0,
            icon: _functionUtil.initIcon(Icons.stop),
            color: Constants.colorCyan,
          ),
        ]),
        if (_duration != null)
          Slider(
              value: _position?.inMilliseconds?.toDouble() ?? 0.0,
              onChanged: (double value) {
                return _audioPlayer.seek((value / 1000).roundToDouble());
              },
              min: 0.0,
              max: _duration.inMilliseconds.toDouble()),
        if (_position != null) _buildMuteButtons(),
        if (_position != null) _buildProgressView()
      ],
    ),
  );

  Row _buildProgressView() => Row(mainAxisSize: MainAxisSize.min, children: [
    Padding(
      padding: _functionUtil.initEdgeInsetsAll(12.0),
      child: CircularProgressIndicator(
        value: _position != null && _position.inMilliseconds > 0
            ? (_position?.inMilliseconds?.toDouble() ?? 0.0) /
            (_duration?.inMilliseconds?.toDouble() ?? 0.0)
            : 0.0,
        valueColor: const AlwaysStoppedAnimation(Constants.colorCyan),
        backgroundColor: Colors.grey.shade400,
      ),
    ),
    _functionUtil.initText2(_position != null
        ? "${positionText ?? ''} / ${durationText ?? ''}"
        : _duration != null ? durationText : '', Constants.colorBlack, Constants.colorTransparent, 24.0),
  ]);

  Row _buildMuteButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        if (!_isMuted)
          FlatButton.icon(
            onPressed: () => _mute(true),
            icon: _functionUtil.initIcon2(Icons.headset_off, Constants.colorCyan),
            label: _functionUtil.initText1('Mute', Constants.colorCyan, Constants.colorTransparent),
          ),
        if (_isMuted)
          FlatButton.icon(
            onPressed: () => _mute(false),
            icon: _functionUtil.initIcon2(Icons.headset, Constants.colorCyan),
            label: _functionUtil.initText1('UnMute', Constants.colorCyan, Constants.colorTransparent),
          ),
      ],
    );
  }

}