class InstagramConstant {
  static InstagramConstant? _instance;
  static InstagramConstant get instance {
    _instance ??= InstagramConstant._init();
    return _instance!;
  }
  InstagramConstant._init();
  static const String clientID = '7';
  static const String appSecret = '6';
  static const String redirectUri = 'https://www.instagram.com';
  static const String scope = 'user_profile';
  static const String responseType = 'code';
  final String url = 'https://api.instagram.com/oauth/authorize?client_id=$clientID&redirect_uri=$redirectUri&scope=user_profile,user_media&response_type=$responseType';
}