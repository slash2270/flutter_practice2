import 'package:json_annotation/json_annotation.dart';

part 'line_pay_on_bean.g.dart';

@JsonSerializable()
class LinePayOnBean{

  String returnCode;
  String returnMessage;
  LinePayOnInfoBean info;

  LinePayOnBean({required this.returnCode, required this.returnMessage, required this.info});

  factory LinePayOnBean.fromJson(Map<String, dynamic> json) => _$LinePayOnBeanFromJson(json);
  Map<String, dynamic> toJson() => _$LinePayOnBeanToJson(this);

}

@JsonSerializable()
class LinePayOnInfoBean{

  LinePayOnPaymentUrlBean paymentUrl;
  int transactionId;
  String paymentAccessToken;

  LinePayOnInfoBean({required this.paymentUrl, required this.transactionId, required this.paymentAccessToken});

  factory LinePayOnInfoBean.fromJson(Map<String, dynamic> json) => _$LinePayOnInfoBeanFromJson(json);
  Map<String, dynamic> toJson() => _$LinePayOnInfoBeanToJson(this);

}

@JsonSerializable()
class LinePayOnPaymentUrlBean{

  String web;
  String app;

  LinePayOnPaymentUrlBean({required this.web, required this.app});

  factory LinePayOnPaymentUrlBean.fromJson(Map<String, dynamic> json) => _$LinePayOnPaymentUrlBeanFromJson(json);
  Map<String, dynamic> toJson() => _$LinePayOnPaymentUrlBeanToJson(this);

}