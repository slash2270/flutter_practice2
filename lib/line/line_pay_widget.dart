import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/line/line_pay_on_bean.dart';
import 'package:flutter_practice2/line/line_pay_under_bean.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:http/http.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class LinePayWidget extends StatefulWidget {
  const LinePayWidget({Key? key}) : super(key: key);

  @override
  State<LinePayWidget> createState() => _LinePayWidgetState();
}

class _LinePayWidgetState extends State<LinePayWidget> {
  late Completer<WebViewController> _controller;
  late FunctionUtil _functionUtil;
  String webUrl = '', _underResponse = '';
  //late Timer _timer;
  double _value = 0.0;
  bool _isVisible = true;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    _onLineResponse();
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

  Future<void> _onLineResponse() async {
    int id = Random().nextInt(99999999);
    var uri = Uri.parse('https://sandbox-api-pay.line.me/v2/payments/request');
    final header = {
      "Content-Type": "application/json",
      "X-LINE-ChannelId": "1",
      "X-LINE-ChannelSecret": "6"
    };
    final body = {
      "productName" : "測試產品1",
      "productImageUrl": "https://ithelp.ithome.com.tw/images/ironman/11th/event/kv_event/bear-fly.svg",
      "amount":100,
      "currency":"TWD",
      "confirmUrl":"http://127.0.0.1:3000",
      "orderId": id,
    };
    Response response = await http.post(uri, headers: header, body: json.encode(body));
    final jsonResponse = json.decode(response.body);
    LogUtil.e('Line Pay On response: $jsonResponse');
    LinePayOnBean linePayBean = LinePayOnBean.fromJson(jsonResponse);
    final jsonInfo = jsonResponse['info'];
    LinePayOnInfoBean info = LinePayOnInfoBean.fromJson(jsonInfo);
    //LogUtil.e('Line Pay Widget jsonInfo: $jsonInfo paymentUrl: ${info.paymentUrl} web: ${info.paymentUrl.web}');

    if(response.statusCode == 200){
      setState(() {
        webUrl = 'https://sandbox-web-pay.line.me/web/payment/wait?transactionReserveId=YnhRS0IzaWpVRGdJbExsTXNManlsOEdLOHBQMUt5dVl2a3hPWFZmS0J0ajB4TXMwQ0YrMmE5d0JEenRmVU50SA';
      });
    } else{
      setState(() {
        webUrl = linePayBean.returnMessage;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillViewport(
            delegate: SliverChildListDelegate([
              _onLinePay(),
              _underLinePay(),
            ])
        )
      ],
    );
  }

  Widget _onLinePay(){
    return webUrl.isNotEmpty ? WebView(
      initialUrl: webUrl,
      javascriptMode: JavascriptMode.unrestricted, // 不受限制
      gestureNavigationEnabled: true, // 指示水平滑動手勢是否會觸發後退列表導航。
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
        /// 阻止導航發生。
        //防止
        /// 允許導航發生。
        //導航
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

  Widget _underLinePay(){
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => _underLineResponse,
            child: _functionUtil.initText2('UnderLinePay', Colors.black, Colors.transparent, 20),),
          _functionUtil.initText2(_underResponse, Colors.black, Colors.transparent, 18),
        ],
      ),
    );
  }

  Future<void> _underLineResponse() async {
    int id = Random().nextInt(99999999);
    int qrCode = Random().nextInt(999999999999999999);
    var uri = Uri.parse('https://sandbox-api-pay.line.me/v2/payments/oneTimeKeys/pay');
    final header = {
      "Content-Type": "application/json",
      "X-LINE-ChannelId": "1657313183",
      "X-LINE-ChannelSecret": "60043b7286ec4b5b0d61d85a117c8a84"
    };
    final body = {
      "productName" : "測試產品1",
      "amount": 100,
      "currency": "TWD",
      "orderId": id,
      "oneTimeKey": '123456789012' // TW 18
    };
    Response response = await http.post(uri, headers: header, body: json.encode(body));
    final jsonResponse = json.decode(response.body);
    LogUtil.e('Line Pay Under response: $jsonResponse');
    LinePayUnderBean linePayUnderBean = LinePayUnderBean.fromJson(jsonResponse);
    final jsonInfo = jsonResponse['info'];
    LinePayUnderInfoBean linePayUnderInfoBean = LinePayUnderInfoBean.fromJson(jsonInfo);
    //LogUtil.e('Line Pay Widget jsonInfo: $jsonInfo paymentUrl: ${info.paymentUrl} web: ${info.paymentUrl.web}');

    if(response.statusCode == 200){
      setState(() {
        _underResponse = jsonResponse;
      });
    }else{
      setState(() {
        _underResponse = linePayUnderBean.returnMessage;
      });
    }
  }

}