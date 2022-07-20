import 'dart:async';
import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/line/line_pay_bean.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class LinePayWidget extends StatefulWidget {
  const LinePayWidget({Key? key}) : super(key: key);

  @override
  State<LinePayWidget> createState() => _LinePayWidgetState();
}

class _LinePayWidgetState extends State<LinePayWidget> {
  late Completer<WebViewController> _controller;
  String webUrl = '';
  //late Timer _timer;
  double _value = 0.0;
  bool _isVisible = true;

  @override
  void initState() {
    getResponse();
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

  Future<void> getResponse() async {
    var uuid = const Uuid().v4();
    var uri = Uri.parse('https://sandbox-api-pay.line.me/v2/payments/request');
    final header = {
      "Content-Type": "application/json",
      "X-LINE-ChannelId": "1657313183",
      "X-LINE-ChannelSecret": "60043b7286ec4b5b0d61d85a117c8a84"
    };
    final body = {
      "productName" : "測試產品1",
      "productImageUrl": "https://ithelp.ithome.com.tw/images/ironman/11th/event/kv_event/bear-fly.svg",
      "amount":100,
      "currency":"TWD",
      "confirmUrl":"www.google.com",
      "orderId":uuid
    };
    Response response = await http.post(uri, headers: header, body: json.encode(body));
    LogUtil.e('Line Pay Widget response: ${jsonDecode(response.body)}');
    LinePayInfoBean linePayInfoBean = LinePayInfoBean.fromJson(json.decode(response.body)['info']);
    LogUtil.e('Line Pay Widget infoLength: ${linePayInfoBean.paymentUrl!.length}');
    LinePayPaymentUrlBean linePayPaymentUrlBean = LinePayPaymentUrlBean();
    if(linePayInfoBean.paymentUrl!.isNotEmpty){
      linePayInfoBean.paymentUrl!.map((element){
        linePayPaymentUrlBean.web = element.web;
        linePayPaymentUrlBean.app = element.app;
      });
    }

    if(response.statusCode == 200){
      setState(() {
        webUrl = linePayPaymentUrlBean.web!;
      });

      final app = linePayPaymentUrlBean.app!;
      LogUtil.e('Line Pay Widget web: $webUrl\napp: $app');
    }

  }

  @override
  Widget build(BuildContext context) {
    return webUrl.isNotEmpty ? WebView(
      initialUrl: webUrl,
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
    ) : const Center(
      child: CircularProgressIndicator(),
    );
  }
}