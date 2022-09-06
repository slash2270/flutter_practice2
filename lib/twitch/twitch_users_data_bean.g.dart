// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twitch_users_data_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TwitchUsersDataBean _$TwitchUsersDataBeanFromJson(Map<String, dynamic> json) =>
    TwitchUsersDataBean(
      data: (json['data'] as List<dynamic>)
          .map((e) => TwitchUsersBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TwitchUsersDataBeanToJson(
        TwitchUsersDataBean instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

TwitchUsersBean _$TwitchUsersBeanFromJson(Map<String, dynamic> json) =>
    TwitchUsersBean(
      id: json['id'] as String,
      login: json['login'] as String,
      display_name: json['display_name'] as String,
      type: json['type'] as String,
      broadcaster_type: json['broadcaster_type'] as String,
      description: json['description'] as String,
      profile_image_url: json['profile_image_url'] as String,
      offline_image_url: json['offline_image_url'] as String,
      email: json['email'] as String,
      created_at: json['created_at'] as String,
      view_count: json['view_count'] as int,
    );

Map<String, dynamic> _$TwitchUsersBeanToJson(TwitchUsersBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'display_name': instance.display_name,
      'type': instance.type,
      'broadcaster_type': instance.broadcaster_type,
      'description': instance.description,
      'profile_image_url': instance.profile_image_url,
      'offline_image_url': instance.offline_image_url,
      'email': instance.email,
      'created_at': instance.created_at,
      'view_count': instance.view_count,
    };
