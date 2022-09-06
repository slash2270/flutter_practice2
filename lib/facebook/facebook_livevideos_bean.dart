import 'package:json_annotation/json_annotation.dart';

part 'facebook_livevideos_bean.g.dart';

@JsonSerializable()
class FacebookLiveVideosBean{

  String id;
  String stream_url;
  String secure_stream_url;

  FacebookLiveVideosBean({required this.id, required this.stream_url, required this.secure_stream_url});

  factory FacebookLiveVideosBean.fromJson(Map<String, dynamic> json) => _$FacebookLiveVideosBeanFromJson(json);
  Map<String, dynamic> toJson() => _$FacebookLiveVideosBeanToJson(this);

  /*
  "id": "1953020644813104",
  "stream_url": "rtmp://rtmp-api.facebook...",
  "secure_stream_url":"rtmps://rtmp-api.facebook..."
   */

}