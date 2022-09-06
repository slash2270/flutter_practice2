// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facebook_livevideos_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacebookLiveVideosBean _$FacebookLiveVideosBeanFromJson(
        Map<String, dynamic> json) =>
    FacebookLiveVideosBean(
      id: json['id'] as String,
      stream_url: json['stream_url'] as String,
      secure_stream_url: json['secure_stream_url'] as String,
    );

Map<String, dynamic> _$FacebookLiveVideosBeanToJson(
        FacebookLiveVideosBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stream_url': instance.stream_url,
      'secure_stream_url': instance.secure_stream_url,
    };
