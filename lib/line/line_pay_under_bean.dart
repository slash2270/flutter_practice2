import 'package:json_annotation/json_annotation.dart';

part 'line_pay_under_bean.g.dart';

/**
 * {
    "returnCode": "0000",
    "returnMessage": "success",
    "info": {
    "transactionId": "2019010112345678910",
    "orderId": "test_order_#1",
    "transactionDate": "2019-01-01T01:01:00Z",
    "payInfo": [{
    "method": "BALANCE",
    "amount": 10
    }, {
    "method": "DISCOUNT",
    "amount": 5
    }],
    "balance": 9900
    }
   }
 */

@JsonSerializable()
class LinePayUnderBean{

  String returnCode;
  String returnMessage;
  LinePayUnderInfoBean info;

  LinePayUnderBean({required this.returnCode, required this.returnMessage, required this.info});

  factory LinePayUnderBean.fromJson(Map<String, dynamic> json) => _$LinePayUnderBeanFromJson(json);
  Map<String, dynamic> toJson() => _$LinePayUnderBeanToJson(this);

}

@JsonSerializable()
class LinePayUnderInfoBean{

  int transactionId;
  String orderId;
  String transactionDate;
  List<LinePayUnderPayInfoBean> payInfo;
  int balance;
  LinePayUnderMerchantBean merchantReference;

  LinePayUnderInfoBean({required this.transactionId, required this.orderId, required this.transactionDate, required this.payInfo, required this.balance, required this.merchantReference});

  factory LinePayUnderInfoBean.fromJson(Map<String, dynamic> json) => _$LinePayUnderInfoBeanFromJson(json);
  Map<String, dynamic> toJson() => _$LinePayUnderInfoBeanToJson(this);

}

@JsonSerializable()
class LinePayUnderPayInfoBean{

  String method;
  String amount;

  LinePayUnderPayInfoBean({required this.method, required this.amount});

  factory LinePayUnderPayInfoBean.fromJson(Map<String, dynamic> json) => _$LinePayUnderPayInfoBeanFromJson(json);
  Map<String, dynamic> toJson() => _$LinePayUnderPayInfoBeanToJson(this);

}

@JsonSerializable()
class LinePayUnderMerchantBean{

  List<LinePayUnderAffiliateCardsBean> affiliateCards;

  LinePayUnderMerchantBean({required this.affiliateCards});

  factory LinePayUnderMerchantBean.fromJson(Map<String, dynamic> json) => _$LinePayUnderMerchantBeanFromJson(json);
  Map<String, dynamic> toJson() => _$LinePayUnderMerchantBeanToJson(this);

}

@JsonSerializable()
class LinePayUnderAffiliateCardsBean{

  String cardType;
  String cardId;

  LinePayUnderAffiliateCardsBean({required this.cardType, required this.cardId});

  factory LinePayUnderAffiliateCardsBean.fromJson(Map<String, dynamic> json) => _$LinePayUnderAffiliateCardsBeanFromJson(json);
  Map<String, dynamic> toJson() => _$LinePayUnderAffiliateCardsBeanToJson(this);

}