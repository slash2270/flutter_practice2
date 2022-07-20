import 'dart:convert';
import 'package:flustars/flustars.dart';
import 'package:http/http.dart' as http;

import 'instagram_constant.dart';

class InstagramModel {
  List<String> userFields = ['id', 'username'];

  String? authorizationCode;
  String? accessToken;
  String? userID;
  String? username;
  Map<String, dynamic>? fields;
  String? mediaID;

  void getAuthorizationCode(String url) {
    authorizationCode = url
        .replaceAll('${InstagramConstant.redirectUri}?code=', '')
        .replaceAll('#_', '');
  }

  Future<bool> getTokenAndUserID() async {
    var url = Uri.parse('https://api.instagram.com/oauth/access_token');
    final response = await http.post(url, body: {
      'client_id': InstagramConstant.clientID,
      'redirect_uri': InstagramConstant.redirectUri,
      'client_secret': InstagramConstant.appSecret,
      'code': authorizationCode,
      'grant_type': 'authorization_code'
    });
    accessToken = json.decode(response.body)['access_token'];
    userID = json.decode(response.body)['user_id'].toString();
    fields = json.decode(response.body)['fields'];
    fields?.isNotEmpty == true ? mediaID = fields!['id'] : mediaID = '';
    LogUtil.e('Instagram Model token: $accessToken userId: $userID mediaID: $mediaID');
    return (accessToken != null && userID != null) ? true : false;
  }

  Future<bool> getUserProfile() async {
    final fields = userFields.join(',');
    final responseNode = await http.get(Uri.parse('https://graph.instagram.com/$userID?fields=$fields&access_token=$accessToken'));
    var instaProfile = {
      'id': json.decode(responseNode.body)['id'].toString(),
      'username': json.decode(responseNode.body)['username'],
    };
    username = json.decode(responseNode.body)['username'];
    print('username: $username');
    return instaProfile != null ? true : false;
  }
}