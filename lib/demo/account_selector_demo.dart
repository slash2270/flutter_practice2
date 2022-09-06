import 'package:account_selector/account.dart';
import 'package:account_selector/account_selector.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class AccountSelectorWidget extends StatefulWidget {
  const AccountSelectorWidget({Key? key}) : super(key: key);

  @override
  _AccountSelectorWidgetState createState() => _AccountSelectorWidgetState();
}

class _AccountSelectorWidgetState extends State<AccountSelectorWidget> {
  String resultText = "";
  List<Account> accountList = [
    Account(
        title: "Bill Gates",
        accountImageWidget: getImage("assets/sample1.jpg")),
    Account(
        title: "Steve Jobs",
        accountImageWidget: getImage("assets/sample2.jpg")),
    Account(
        title: "Mark Elliot Zuckerberg",
        accountImageWidget: getImage("assets/sample3.jpg")),
    Account(
        title: "Sundar Pichai",
        accountImageWidget: getImage("assets/sample4.jpg")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Selector Demo"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(resultText),
              ),
              RaisedButton(
                onPressed: () {
                  showAccountSelectorSheet(
                    context: context,
                    accountList: accountList,
                    isSheetDismissible: false, //Optional
                    initiallySelectedIndex: 2, //Optional
                    hideSheetOnItemTap: true, //Optional
                    addAccountTitle: "添加用戶", //Optional
                    showAddAccountOption: true, //Optional
                    backgroundColor: Colors.indigo, //Optional
                    arrowColor: Colors.white, //Optional
                    unselectedRadioColor: Colors.white, //Optional
                    selectedRadioColor: Colors.amber, //Optional
                    unselectedTextColor: Colors.white, //Optional
                    selectedTextColor: Colors.amber, //Optional
                    //Optional
                    tapCallback: (index) {
                      setState(() {
                        resultText = "選擇的帳戶是: ${accountList[index].title}";
                      });
                      LogUtil.e(resultText);
                    },
                    //Optional
                    addAccountTapCallback: () {
                      setState(() {
                        resultText = "添加帳戶點擊";
                      });
                      LogUtil.e(resultText);
                    },
                  );
                },
                child: const Text("單一賬戶選擇器"),
              ),
              RaisedButton(
                onPressed: () async {
                  var res = await showMultiAccountSelectorSheet(
                    context: context,
                    accountList: accountList,
                    initiallySelectedIndexList: [0, 2], //Optional
                    isSheetDismissible: false, //Optional
                    backgroundColor: Colors.orange[100], //Optional
                    arrowColor: Colors.purple, //Optional
                    doneButtonColor: Colors.purple, //Optional
                    doneText: "Done", //Optional
                    checkedIconColor: Colors.purple, //Optional
                    selectedTextColor: Colors.purple, //Optional
                    uncheckedIconColor: Colors.grey[800], //Optional
                    unselectedTextColor: Colors.grey[800], //Optional
                  );
                  setState(() {
                    resultText = "選擇的索引列表: ${res.toString()}";
                  });
                  LogUtil.e(resultText);
                },
                child: const Text("多賬戶選擇器"),
              ),
            ],
          )),
    );
  }

  static getImage(String assetPath) {
    return Image.asset(assetPath, fit: BoxFit.cover);
  }
}