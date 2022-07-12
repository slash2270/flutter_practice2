import 'package:flutter/material.dart';

class ReduxSearchInitialView extends StatelessWidget {
  const ReduxSearchInitialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.info, color: Colors.green[200], size: 80.0),
          Container(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              '輸入搜索詞開始',
              style: TextStyle(
                color: Colors.green[100],
              ),
            ),
          )
        ],
      ),
    );
  }
}
