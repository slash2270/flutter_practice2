import 'package:json_annotation/json_annotation.dart';

part 'twitch_authorize_bean.g.dart';

@JsonSerializable()
class TwitchAuthorizeBean{

  String access_token, token_type;
  int expires_in;

  TwitchAuthorizeBean({required this.access_token, required this.expires_in, required this.token_type});

  factory TwitchAuthorizeBean.fromJson(Map<String, dynamic> json) => _$TwitchAuthorizeBeanFromJson(json);
  Map<String, dynamic> toJson() => _$TwitchAuthorizeBeanToJson(this);

}