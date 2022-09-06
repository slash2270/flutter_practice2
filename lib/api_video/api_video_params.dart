import 'dart:core';

import 'package:apivideo_live_stream/apivideo_live_stream.dart';
import 'package:flutter_practice2/api_video/api_video_channel.dart';
import 'package:flutter_practice2/api_video/api_video_resolution.dart';
import 'package:flutter_practice2/api_video/api_video_sample_rate.dart';

import '../util/constants.dart';

List<int> fpsList = [24, 25, 30];
List<int> audioBitrateList = [32000, 64000, 128000, 192000];

String defaultValueTransformation(int e) {
  return "$e";
}

extension ListExtension on List<int> {
  Map<int, String> toMap(
      {Function(int e) valueTransformation = defaultValueTransformation}) {
    Map<int, String> map = { for (var e in this) e : valueTransformation(e) };
    return map;
  }
}

String bitrateToPrettyString(int bitrate) {
  return "${bitrate / 1000} Kbps";
}

class ApiVideoParams {
  final VideoConfig video = VideoConfig.withDefaultBitrate();
  final AudioConfig audio = AudioConfig();

  String rtmpUrl = Constants.twitchStreamRtmp2;
  String streamKey = Constants.twitchStaticKey;

  String getResolutionToString() {
    return video.resolution.toPrettyString();
  }

  String getChannelToString() {
    return audio.channel.toPrettyString();
  }

  String getBitrateToString() {
    return bitrateToPrettyString(audio.bitrate);
  }

  String getSampleRateToString() {
    return audio.sampleRate.toPrettyString();
  }
}