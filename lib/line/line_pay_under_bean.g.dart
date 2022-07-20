// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_pay_under_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinePayUnderBean _$LinePayUnderBeanFromJson(Map<String, dynamic> json) =>
    LinePayUnderBean(
      returnCode: json['returnCode'] as String,
      returnMessage: json['returnMessage'] as String,
      info: LinePayUnderInfoBean.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LinePayUnderBeanToJson(LinePayUnderBean instance) =>
    <String, dynamic>{
      'returnCode': instance.returnCode,
      'returnMessage': instance.returnMessage,
      'info': instance.info,
    };

LinePayUnderInfoBean _$LinePayUnderInfoBeanFromJson(
        Map<String, dynamic> json) =>
    LinePayUnderInfoBean(
      transactionId: json['transactionId'] as int,
      orderId: json['orderId'] as String,
      transactionDate: json['transactionDate'] as String,
      payInfo: (json['payInfo'] as List<dynamic>)
          .map((e) =>
              LinePayUnderPayInfoBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      balance: json['balance'] as int,
      merchantReference: LinePayUnderMerchantBean.fromJson(
          json['merchantReference'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LinePayUnderInfoBeanToJson(
        LinePayUnderInfoBean instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'orderId': instance.orderId,
      'transactionDate': instance.transactionDate,
      'payInfo': instance.payInfo,
      'balance': instance.balance,
      'merchantReference': instance.merchantReference,
    };

LinePayUnderPayInfoBean _$LinePayUnderPayInfoBeanFromJson(
        Map<String, dynamic> json) =>
    LinePayUnderPayInfoBean(
      method: json['method'] as String,
      amount: json['amount'] as String,
    );

Map<String, dynamic> _$LinePayUnderPayInfoBeanToJson(
        LinePayUnderPayInfoBean instance) =>
    <String, dynamic>{
      'method': instance.method,
      'amount': instance.amount,
    };

LinePayUnderMerchantBean _$LinePayUnderMerchantBeanFromJson(
        Map<String, dynamic> json) =>
    LinePayUnderMerchantBean(
      affiliateCards: (json['affiliateCards'] as List<dynamic>)
          .map((e) => LinePayUnderAffiliateCardsBean.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LinePayUnderMerchantBeanToJson(
        LinePayUnderMerchantBean instance) =>
    <String, dynamic>{
      'affiliateCards': instance.affiliateCards,
    };

LinePayUnderAffiliateCardsBean _$LinePayUnderAffiliateCardsBeanFromJson(
        Map<String, dynamic> json) =>
    LinePayUnderAffiliateCardsBean(
      cardType: json['cardType'] as String,
      cardId: json['cardId'] as String,
    );

Map<String, dynamic> _$LinePayUnderAffiliateCardsBeanToJson(
        LinePayUnderAffiliateCardsBean instance) =>
    <String, dynamic>{
      'cardType': instance.cardType,
      'cardId': instance.cardId,
    };
