import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'instagram_constant.dart';
import 'instagram_model.dart';
import 'instagram_token_view.dart';

class InstagramView extends StatefulWidget {
  const InstagramView({Key? key}) : super(key: key);

  @override
  State<InstagramView> createState() => _InstagramViewState();
}

class _InstagramViewState extends State<InstagramView> {

  late Completer<WebViewController> _controller;
  //late Timer _timer;
  double _value = 0.0;
  bool _isVisible = true;

  @override
  void initState() {
    _initWebView();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _initWebView(){
    //_setTimer();
    _controller = Completer<WebViewController>();
    WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final webView = FlutterWebviewPlugin();
    final InstagramModel instagram = InstagramModel();
    buildRedirectToHome(webView, instagram, context);
    /*return WebviewScaffold(
  url: InstagramConstant.instance.url,
  resizeToAvoidBottomInset: true,
  appBar: _buildAppBar(context),
  );*/
    return WebView(
      initialUrl: InstagramConstant.instance.url,
      javascriptMode: JavascriptMode.unrestricted,
      gestureNavigationEnabled: true,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      onProgress: (int progress) {
        setState(() {
          _value = progress.toDouble();
          if(progress == 100){
            _isVisible = false;
          }
        });
        //print("載入中... (progress : $progress%)");
      },
      navigationDelegate: (NavigationRequest request) {
        return NavigationDecision.navigate;
      },
      onPageStarted: (String url) {
        //print('開始載入: $url');
      },
      onPageFinished: (String url) {
        //print('結束載入: $url');
      },
    );
  }

  Future<void> buildRedirectToHome(FlutterWebviewPlugin webView, InstagramModel instagram, BuildContext context) async {
    webView.onUrlChanged.listen((String url) async {
      if (url.contains(InstagramConstant.redirectUri)) {
        instagram.getAuthorizationCode(url);
        await instagram.getTokenAndUserID().then((isDone) {
          if (isDone) {
            instagram.getUserProfile().then((isDone) async {
              await webView.close();

              print('${instagram.username} logged in!');

              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => InstagramTokenView(
                    token: instagram.authorizationCode.toString(),
                    name: instagram.username.toString(),
                  ),
                ),
              );
            });
          }
        });
      }
    });
  }

  AppBar _buildAppBar(BuildContext context) => AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
    title: Text(
      'Instagram Login',
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(color: Colors.black),
    ),
  );
}