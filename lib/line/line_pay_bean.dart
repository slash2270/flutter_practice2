import 'package:json_annotation/json_annotation.dart';

part 'line_pay_bean.g.dart';

@JsonSerializable()
class LinePayBean{

  int? returnCode;
  String? returnMessage;
  List<LinePayInfoBean>? info;

  LinePayBean({this.returnCode, this.returnMessage, this.info});

  factory LinePayBean.fromJson(Map<String, dynamic> json) => _$LinePayBeanFromJson(json);
  Map<String, dynamic> toJson() => _$LinePayBeanToJson(this);

}

@JsonSerializable()
class LinePayInfoBean{

  List<LinePayPaymentUrlBean>? paymentUrl;
  int? transactionId;
  int? paymentAccessToken;

  LinePayInfoBean({this.paymentUrl, this.transactionId, this.paymentAccessToken});

  factory LinePayInfoBean.fromJson(Map<String, dynamic> json) => _$LinePayInfoBeanFromJson(json);
  Map<String, dynamic> toJson() => _$LinePayInfoBeanToJson(this);

}

@JsonSerializable()
class LinePayPaymentUrlBean{

  String? web;
  String? app;

  LinePayPaymentUrlBean({this.web, this.app});

  factory LinePayPaymentUrlBean.fromJson(Map<String, dynamic> json) => _$LinePayPaymentUrlBeanFromJson(json);
  Map<String, dynamic> toJson() => _$LinePayPaymentUrlBeanToJson(this);

}