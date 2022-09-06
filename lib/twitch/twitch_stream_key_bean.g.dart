// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twitch_stream_key_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TwitchStreamKeyDataBean _$TwitchStreamKeyDataBeanFromJson(
        Map<String, dynamic> json) =>
    TwitchStreamKeyDataBean(
      data: (json['data'] as List<dynamic>)
          .map((e) => TwitchStreamKeyBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TwitchStreamKeyDataBeanToJson(
        TwitchStreamKeyDataBean instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

TwitchStreamKeyBean _$TwitchStreamKeyBeanFromJson(Map<String, dynamic> json) =>
    TwitchStreamKeyBean(
      stream_key: json['stream_key'] as String,
    );

Map<String, dynamic> _$TwitchStreamKeyBeanToJson(
        TwitchStreamKeyBean instance) =>
    <String, dynamic>{
      'stream_key': instance.stream_key,
    };
