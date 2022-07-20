// @dart = 2.9

import 'package:flutter/material.dart';
import 'package:flutter_practice2/instagram/token_bean.dart';
import 'login_presenter.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text("Instagram Auth"),
        ),
        body: LoginScreen(_scaffoldKey)
    );
  }

}

/// Contact List
class LoginScreen extends StatefulWidget{
  LoginScreen(this.skey, {Key key}) : super(key: key);
  GlobalKey<ScaffoldState> skey;

  @override
  _LoginScreenState createState() => _LoginScreenState(skey);
}

class _LoginScreenState extends State<LoginScreen> implements LoginViewContract {
  LoginPresenter _presenter;
  bool _isLoading;
  TokenBean token;
  GlobalKey<ScaffoldState> _scaffoldKey;

  _LoginScreenState(GlobalKey<ScaffoldState> skey) {
    _presenter = LoginPresenter(this);
    _scaffoldKey = skey;
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(value)
    ));
  }

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  void onLoginError(String msg) {
    setState(() {
      _isLoading = false;
    });
    showInSnackBar(msg);
  }

  @override
  void onLoginSuccess(TokenBean t) {
    setState(() {
      _isLoading = false;
      token = t;
    });
    showInSnackBar('Login Successful');
  }

  @override
  Widget build(BuildContext context) {
    SingleChildRenderObjectWidget widget;
    if(_isLoading) {
      widget = const Center(
          child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: CircularProgressIndicator()
          )
      );
    } else if(token != null){
      widget = Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(token.fullName,
                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),),
                Text(token.userName),
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(token.profilePicture),
                    radius: 50.0,
                  ),
                ),
              ]
          )
      );
    }
    else {
      widget = Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Welcome to InstagramAuth,',
                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),),
                const Text('Login to continue'),
                Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 160.0),
                      child:
                      InkWell(
                        onTap: _login,
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Image.asset(
                            'assets/instagram.png',
                            height: 50.0,
                            fit: BoxFit.cover,
                          ),
                          const Text('Continue with Instagram')
                        ],
                      ),)
                  ),
                ),
              ]
          )
      );
    }
    return widget;
  }

  void _login(){
    setState(() {
      _isLoading = true;
    });
    _presenter.performLogin();
  }

}