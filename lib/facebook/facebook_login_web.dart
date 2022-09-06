import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../util/constants.dart';

class FacebookLoginWeb extends StatefulWidget {
  const FacebookLoginWeb({Key? key}) : super(key: key);

  @override
  State<FacebookLoginWeb> createState() => _FacebookLoginWebState();
}

class _FacebookLoginWebState extends State<FacebookLoginWeb> {

  late Completer<WebViewController> _controller;
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
    _controller = Completer<WebViewController>();
    WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: Constants.facebookLoginApi,
      javascriptMode: JavascriptMode.unrestricted,
      // 不受限制
      gestureNavigationEnabled: true,
      // 指示水平滑動手勢是否會觸發後退列表導航。
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      onProgress: (int progress) {
        setState(() {
          _value = progress.toDouble();
          if (progress == 100) {
            _isVisible = false;
          }
        });
        // LogUtil.e("載入中... (progress : $progress%)");
      },
      navigationDelegate: (NavigationRequest request) {
        /// 阻止導航發生。
        //防止
        /// 允許導航發生。
        //導航
        return NavigationDecision.navigate;
      },
      onPageStarted: (String url) {
        // LogUtil.e('開始載入: $url');
      },
      onPageFinished: (String url) {
        // LogUtil.e('結束載入: $url');
      },
    );
  }

}