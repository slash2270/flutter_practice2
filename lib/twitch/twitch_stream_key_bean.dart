import 'package:json_annotation/json_annotation.dart';

part 'twitch_stream_key_bean.g.dart';

@JsonSerializable()
class TwitchStreamKeyDataBean{

  List<TwitchStreamKeyBean> data;

  TwitchStreamKeyDataBean({required this.data});

  factory TwitchStreamKeyDataBean.fromJson(Map<String, dynamic> json) => _$TwitchStreamKeyDataBeanFromJson(json);
  Map<String, dynamic> toJson() => _$TwitchStreamKeyDataBeanToJson(this);

}

@JsonSerializable()
class TwitchStreamKeyBean{

  String stream_key;

  TwitchStreamKeyBean({required this.stream_key});

  factory TwitchStreamKeyBean.fromJson(Map<String, dynamic> json) => _$TwitchStreamKeyBeanFromJson(json);
  Map<String, dynamic> toJson() => _$TwitchStreamKeyBeanToJson(this);

}