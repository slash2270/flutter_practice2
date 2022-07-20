import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'line_theme.dart';
import 'line_user_info_widget.dart';

class LineUser extends StatefulWidget {
  const LineUser({Key? key}) : super(key: key);

  @override
  _LineUserState createState() => _LineUserState();
}

class _LineUserState extends State<LineUser> with AutomaticKeepAliveClientMixin {
  UserProfile? _userProfile;
  String? _userEmail;
  StoredAccessToken? _accessToken;
  bool _isOnlyWebLogin = false;

  final Set<String> _selectedScopes = {'profile'};

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    UserProfile? userProfile;
    StoredAccessToken? accessToken;

    try {
      accessToken = await LineSDK.instance.currentAccessToken;
      if (accessToken != null) {
        userProfile = await LineSDK.instance.getProfile();
      }
    } on PlatformException catch (e) {
      LogUtil.e(e.message);
    }

    if (!mounted) return;

    setState(() {
      _userProfile = userProfile;
      _accessToken = accessToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_userProfile == null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            _configCard(),
            Expanded(
              child: Center(
                  child: ElevatedButton(
                      onPressed: _signIn,
                      style: ElevatedButton.styleFrom(
                          primary: accentColor, onPrimary: textColor),
                      child: const Text('登入'))),
            ),
          ],
        ),
      );
    } else {
      return LineUserInfoWidget(
        userProfile: _userProfile!,
        userEmail: _userEmail,
        accessToken: _accessToken!,
        onSignOutPressed: _signOut,
      );
    }
  }

  Widget _configCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _scopeListUI(),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  activeColor: accentColor,
                  value: _isOnlyWebLogin,
                  onChanged: (bool? value) {
                    setState(() {
                      _isOnlyWebLogin = !_isOnlyWebLogin;
                    });
                  },
                ),
                const Text('只有網頁登入'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _scopeListUI() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text('範圍: '),
      Wrap(
        children:
        _scopes.map<Widget>((scope) => _buildScopeChip(scope)).toList(),
      ),
    ],
  );

  Widget _buildScopeChip(String scope) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: ChipTheme(
      data: ChipTheme.of(context).copyWith(brightness: Brightness.dark),
      child: FilterChip(
        label: Text(scope, style: const TextStyle(color: textColor)),
        selectedColor: accentColor,
        backgroundColor: secondaryBackgroundColor,
        selected: _selectedScopes.contains(scope),
        onSelected: (_) {
          setState(() {
            _selectedScopes.contains(scope)
                ? _selectedScopes.remove(scope)
                : _selectedScopes.add(scope);
          });
        },
      ),
    ),
  );

  void _signIn() async {
    try {
      /// requestCode 僅適用於 Android 平台，請在您的應用程序中使用另一個唯一值。
      final loginOption = LoginOption(_isOnlyWebLogin, 'normal', requestCode: 7791); //8192
      final result = await LineSDK.instance.login(scopes: _selectedScopes.toList(), option: loginOption);
      final accessToken = await LineSDK.instance.currentAccessToken;
      final userEmail = result.accessToken.email;
      setState(() {
        _userProfile = result.userProfile;
        _userEmail = userEmail;
        _accessToken = accessToken;
      });
    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _signOut() async {
    try {
      await LineSDK.instance.logout();
      setState(() {
        _userProfile = null;
        _userEmail = null;
        _accessToken = null;
      });
    } on PlatformException catch (e) {
      LogUtil.e(e.message);
    }
  }

  void _showDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(text),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(primary: accentColor),
                child: const Text('關閉')),
          ],
        );
      },
    );
  }
}

const List<String> _scopes = <String>['profile', 'openid', 'mail'];