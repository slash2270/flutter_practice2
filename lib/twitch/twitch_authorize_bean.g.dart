// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twitch_authorize_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TwitchAuthorizeBean _$TwitchAuthorizeBeanFromJson(Map<String, dynamic> json) =>
    TwitchAuthorizeBean(
      access_token: json['access_token'] as String,
      expires_in: json['expires_in'] as int,
      token_type: json['token_type'] as String,
    );

Map<String, dynamic> _$TwitchAuthorizeBeanToJson(
        TwitchAuthorizeBean instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'token_type': instance.token_type,
      'expires_in': instance.expires_in,
    };
