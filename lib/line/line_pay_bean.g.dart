// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_pay_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinePayBean _$LinePayBeanFromJson(Map<String, dynamic> json) => LinePayBean(
      returnCode: json['returnCode'] as int?,
      returnMessage: json['returnMessage'] as String?,
      info: (json['info'] as List<dynamic>?)
          ?.map((e) => LinePayInfoBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LinePayBeanToJson(LinePayBean instance) =>
    <String, dynamic>{
      'returnCode': instance.returnCode,
      'returnMessage': instance.returnMessage,
      'info': instance.info,
    };

LinePayInfoBean _$LinePayInfoBeanFromJson(Map<String, dynamic> json) =>
    LinePayInfoBean(
      paymentUrl: (json['paymentUrl'] as List<dynamic>?)
          ?.map(
              (e) => LinePayPaymentUrlBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      transactionId: json['transactionId'] as int?,
      paymentAccessToken: json['paymentAccessToken'] as int?,
    );

Map<String, dynamic> _$LinePayInfoBeanToJson(LinePayInfoBean instance) =>
    <String, dynamic>{
      'paymentUrl': instance.paymentUrl,
      'transactionId': instance.transactionId,
      'paymentAccessToken': instance.paymentAccessToken,
    };

LinePayPaymentUrlBean _$LinePayPaymentUrlBeanFromJson(
        Map<String, dynamic> json) =>
    LinePayPaymentUrlBean(
      web: json['web'] as String?,
      app: json['app'] as String?,
    );

Map<String, dynamic> _$LinePayPaymentUrlBeanToJson(
        LinePayPaymentUrlBean instance) =>
    <String, dynamic>{
      'web': instance.web,
      'app': instance.app,
    };
