// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_pay_on_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinePayOnBean _$LinePayOnBeanFromJson(Map<String, dynamic> json) =>
    LinePayOnBean(
      returnCode: json['returnCode'] as String,
      returnMessage: json['returnMessage'] as String,
      info: LinePayOnInfoBean.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LinePayOnBeanToJson(LinePayOnBean instance) =>
    <String, dynamic>{
      'returnCode': instance.returnCode,
      'returnMessage': instance.returnMessage,
      'info': instance.info,
    };

LinePayOnInfoBean _$LinePayOnInfoBeanFromJson(Map<String, dynamic> json) =>
    LinePayOnInfoBean(
      paymentUrl: LinePayOnPaymentUrlBean.fromJson(
          json['paymentUrl'] as Map<String, dynamic>),
      transactionId: json['transactionId'] as int,
      paymentAccessToken: json['paymentAccessToken'] as String,
    );

Map<String, dynamic> _$LinePayOnInfoBeanToJson(LinePayOnInfoBean instance) =>
    <String, dynamic>{
      'paymentUrl': instance.paymentUrl,
      'transactionId': instance.transactionId,
      'paymentAccessToken': instance.paymentAccessToken,
    };

LinePayOnPaymentUrlBean _$LinePayOnPaymentUrlBeanFromJson(
        Map<String, dynamic> json) =>
    LinePayOnPaymentUrlBean(
      web: json['web'] as String,
      app: json['app'] as String,
    );

Map<String, dynamic> _$LinePayOnPaymentUrlBeanToJson(
        LinePayOnPaymentUrlBean instance) =>
    <String, dynamic>{
      'web': instance.web,
      'app': instance.app,
    };
