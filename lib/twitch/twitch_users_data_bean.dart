import 'package:json_annotation/json_annotation.dart';

part 'twitch_users_data_bean.g.dart';

@JsonSerializable()
class TwitchUsersDataBean{

  List<TwitchUsersBean> data;

  TwitchUsersDataBean({required this.data});

  factory TwitchUsersDataBean.fromJson(Map<String, dynamic> json) => _$TwitchUsersDataBeanFromJson(json);
  Map<String, dynamic> toJson() => _$TwitchUsersDataBeanToJson(this);

}

@JsonSerializable()
class TwitchUsersBean{

  String id, login, display_name, type, broadcaster_type, description, profile_image_url, offline_image_url, email, created_at;
  int view_count;

  TwitchUsersBean({required this.id, required this.login, required this.display_name, required this.type, required this.broadcaster_type, required this.description, required this.profile_image_url, required this.offline_image_url, required this.email, required this.created_at, required this.view_count});

  factory TwitchUsersBean.fromJson(Map<String, dynamic> json) => _$TwitchUsersBeanFromJson(json);
  Map<String, dynamic> toJson() => _$TwitchUsersBeanToJson(this);

}