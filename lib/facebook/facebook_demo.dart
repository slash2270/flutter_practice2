import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_practice2/facebook/facebook_auth_demo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FacebookLoginDemo extends StatefulWidget {
  final FacebookLogin plugin;

  const FacebookLoginDemo({Key? key, required this.plugin}) : super(key: key);

  @override
  _FacebookLoginDemoState createState() => _FacebookLoginDemoState();
}

class _FacebookLoginDemoState extends State<FacebookLoginDemo> {
  String? _sdkVersion;
  FacebookAccessToken? _token;
  FacebookUserProfile? _profile;
  String? _email;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _getSdkVersion();
    _updateLoginInfo();
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = _token != null && _profile != null;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook Login Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              if (_sdkVersion != null) Text('SDK v$_sdkVersion'),
              if (isLogin)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildUserInfo(context, _profile!, _token!, _email),
                ),
              isLogin
                  ? OutlinedButton(
                onPressed: _onPressedLogOutButton,
                child: const Text('登出'),
              )
                  : OutlinedButton(
                onPressed: _onPressedLogInButton,
                child: const Text('登入'),
              ),
              if (!isLogin && Platform.isAndroid)
                OutlinedButton(
                  child: const Text('快速登錄'),
                  onPressed: () => _onPressedExpressLogInButton(context),
                ),
              const FacebookAuthDemo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, FacebookUserProfile profile, FacebookAccessToken accessToken, String? email) {
    final avatarUrl = _imageUrl;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (avatarUrl != null)
          Center(
            child: Image.network(avatarUrl),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text('使用者: '),
            Text(
              '${profile.firstName} ${profile.lastName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Text('高級令牌: '),
        Text(
          accessToken.token,
          softWrap: true,
        ),
        if (email != null) Text('郵件: $email'),
      ],
    );
  }

  Future<void> _onPressedLogInButton() async {
    await widget.plugin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    await _updateLoginInfo();
  }

  Future<void> _onPressedExpressLogInButton(BuildContext context) async {
    final res = await widget.plugin.expressLogin();
    if (res.status == FacebookLoginStatus.success) {
      await _updateLoginInfo();
    } else {
      await showDialog<Object>(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text("無法進行快速登錄。請嘗試常規登錄。"),
        ),
      );
    }
  }

  Future<void> _onPressedLogOutButton() async {
    await widget.plugin.logOut();
    await _updateLoginInfo();
  }

  Future<void> _getSdkVersion() async {
    final sdkVersion = await widget.plugin.sdkVersion;
    setState(() {
      _sdkVersion = sdkVersion;
    });
  }

  Future<void> _updateLoginInfo() async {
    final plugin = widget.plugin;
    final token = await plugin.accessToken;
    FacebookUserProfile? profile;
    String? email;
    String? imageUrl;
    // LogUtil.e('Facebook token: ${token != null}');
    if (token != null) {
      profile = await plugin.getUserProfile();
      if (token.permissions.contains(FacebookPermission.email.name)) {
        email = await plugin.getUserEmail();
      }
      imageUrl = await plugin.getProfileImageUrl(width: 100);
      // LogUtil.e('Facebook user token: ${token.token} ${token.userId} ${plugin.getUserEmail()} ${plugin.getUserProfile()}');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('facebook_token', token.token);
    }

    setState(() {
      _token = token;
      _profile = profile;
      _email = email;
      _imageUrl = imageUrl;
      // LogUtil.e('Facebook url: $_imageUrl');
    });
  }
}