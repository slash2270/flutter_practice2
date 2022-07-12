// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:money2/money2.dart';

class MoneyDemo  extends StatefulWidget {
  const MoneyDemo ({Key? key}) : super(key: key);

  @override
  _MoneyDemoState createState() => _MoneyDemoState();
}

class _MoneyDemoState extends State<MoneyDemo> {

  late FunctionUtil _functionUtil;
  late final String _money = '';

  @override
  void initState() {
    super.initState();
    _functionUtil = FunctionUtil();
    _getMoney();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _functionUtil.initText2('Money 貨幣金額解析', Colors.black, Colors.transparent, 24),
        _functionUtil.initText2(_money, Colors.green.shade400, Colors.transparent, 18),
      ],
    );
  }

  _getMoney(){

    setState(() {
      /// Create money from Fixed amount

      //final fixed = Fixed.fromInt(100, scale: 2);
      Money.parse('1.23', code: 'AUD');
      //Money.fromFixed(fixed, code: 'AUD');

      //Money.fromDecimal(Decimal.parse('1.23'), code: 'EUR');

      //_money += "1.23 AUD:${Money.parse('1.23', code: 'AUD')}";

      ///
      /// Create a money which stores $USD 10.00
      ///
      /// Note: we use the minor unit (e.g. cents) when passing in the
      ///   monetary value.
      /// So $10.00 is 1000 cents.
      ///
      final costPrice = Money.fromInt(1000, code: 'USD');
      print(costPrice.toString());
// > $10.00
      //_money += "1000 USD:$costPrice";

      ///
      /// Create a [Money] instance from a String
      /// using [Currency.parse]
      /// The [Currency] of salePrice is USD.
      ///
      final salePrice = CommonCurrencies().usd.parse(r'$10.50');
      print(salePrice.format('SCC 0.0'));
// > $US 10.50
      //_money += "\n${salePrice.format('SCC 0.0')}";

      ///
      /// Create a [Money] instance from a String
      /// using [Money.parse]
      ///
      final taxPrice = Money.parse(r'$1.50', code: 'USD');
      print(taxPrice.format('CC 0.0 S'));
// > US 1.50 $
      //_money += "\n${taxPrice.format('CC 0.0 S')}";

      ///
      /// Create a [Money] instance from a String
      /// with an embedded Currency Code
      /// using [Currencies.parse]
      ///
      /// Create a custom currency
      /// USD currency uses 2 decimals, we need 3.
      ///
      final usd = Currency.create('USD', 3);
      //_money += "\n$usd";

      final cheapIPhone = Currencies().parse(r'$USD1500.0', pattern: 'SCCC0.0');
      print(cheapIPhone.format('SCC0.0'));
// > $US1500.00

      final expensiveIPhone = Currencies().parse(
          r'$AUD2000.0', pattern: 'SCCC0.0');
      print(expensiveIPhone.format('SCC0.0'));
// > $AUD2000.00

      /// Register a non-common currency (dogecoin)
      Currencies().register(Currency.create('DODGE', 5, symbol: 'Ð'));
      final dodge = Currencies().find('DODGE');
      //Money.fromNumWithCurrency(0.1123, dodge!);
      //Money.fromNum(0.1123, code: 'DODGE');

      ///
      /// Do some maths
      ///
      final taxInclusive = costPrice * 1.1;

      ///
      /// Output the result using the default format.
      ///
      print(taxInclusive.toString());
// > $11.00

      ///
      /// Do some custom formatting of the ouput
      /// S - the symbol e.g. $
      /// CC - first two digits of the currency code provided when creating
      ///     the currency.
      /// # - a digit if required
      /// 0 - a digit or the zero character as padding.
      print(taxInclusive.format('SCC #.00'));
// > $US 11.00

      ///
      /// Explicitly define the symbol and the default pattern to be used
      ///    when calling [Money.toString()]
      ///
      /// JPY - code for japenese yen.
      /// 0 - the number of minor units (e.g cents) used by the currency.
      ///     The yen has no minor units.
      /// ¥ - currency symbol for the yen
      /// S0 - the default pattern for [Money.toString()].
      ///      S output the symbol.
      ///      0 - force at least a single digit in the output.
      ///
      final jpy = Currency.create('JPY', 0, symbol: '¥', pattern: 'S0');
      final jpyMoney = Money.fromIntWithCurrency(500, jpy);
      print(jpyMoney.toString());
// > ¥500

      ///
      /// Define a currency that has inverted separators.
      /// i.e. The USD uses '.' for the integer/fractional separator
      ///      and ',' for the group separator.
      ///      -> 1,000.00
      /// The EURO use ',' for the integer/fractional separator
      ///      and '.' for the group separator.
      ///      -> 1.000,00
      ///
      final euro = Currency.create('EUR', 2,
          symbol: '€', invertSeparators: true, pattern: '#.##0,00 S');

      final bmwPrice = Money.fromIntWithCurrency(10025090, euro);
      print(bmwPrice.toString());
// > 100.250,90 €

      ///
      /// Formatting examples
      ///
      ///

// 100,345.30 usd
      final teslaPrice = Money.fromInt(10034530, code: 'USD');

      print(teslaPrice.format('###,###'));
// > 100,345

      print(teslaPrice.format('S###,###.##'));
// > $100,345.3

      print(teslaPrice.format('CC###,###.#0'));
// > US100,345.30

// 100,345.30 EUR
      final euroCostPrice = Money.fromInt(10034530, code: 'EUR');
      print(euroCostPrice.format('###.###'));
// > 100.345

      print(euroCostPrice.format('###.###,## S'));
// > 100.345,3 €

      print(euroCostPrice.format('###.###,#0 CC'));
// > 100.345,30 EU

      ///
      /// Make the currencies available globally by registering them
      ///     with the [Currencies] singleton factory.
      ///
      Currencies().register(usd);
      Currencies().register(euro);
      Currencies().register(jpy);

// use a registered currency by finding it in the registry using
// the currency code that the currency was created with.
      final usDollar = Currencies().find('USD');

      final invoicePrice = Money.fromIntWithCurrency(1000, usDollar!);

      ///
      print(invoicePrice.format('SCCC 0.00'));
// $USD 10.00

// Do some maths
      final taxInclusivePrice = invoicePrice * 1.1;
      print(taxInclusivePrice.toString());
// $11.00

      print(taxInclusivePrice.format('SCC 0.00'));
// $US 11.00

// retrieve all registered currencies
      final Iterable<Currency> registeredCurrencies = Currencies()
          .getRegistered();
      final Iterable<String> codes = registeredCurrencies.map((c) => c.code);
      print(codes);
// (USD, AUD, EUR, JPY)
    });
  }
}