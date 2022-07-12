import 'dart:async';

import 'package:flutter/material.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';

const storedPasscode = '123456';

class PassCodeScreenWidget extends StatefulWidget {
  const PassCodeScreenWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PassCodeScreenWidgetState();
}

class _PassCodeScreenWidgetState extends State<PassCodeScreenWidget> {
  final StreamController<bool> _verificationNotifier = StreamController<bool>.broadcast();

  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('認證${isAuthenticated ? '成功' : '錯誤'}'),
            _defaultLockScreenButton(context),
            _customColorsLockScreenButton(context)
          ],
    );
  }

  _defaultLockScreenButton(BuildContext context) => MaterialButton(
    color: Theme.of(context).primaryColor,
    child: const Text('打開默認鎖屏'),
    onPressed: () {
      _showLockScreen(
        context,
        opaque: false,
        cancelButton: const Text(
          '取消',
          style: TextStyle(fontSize: 16, color: Colors.white),
          semanticsLabel: '取消',
        ),
      );
    },
  );

  _customColorsLockScreenButton(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).primaryColor,
      child: const Text('打開自定義鎖屏'),
      onPressed: () {
        _showLockScreen(context,
            opaque: false,
            circleUIConfig: const CircleUIConfig(
                borderColor: Colors.blue,
                fillColor: Colors.blue,
                circleSize: 30),
            keyboardUIConfig: const KeyboardUIConfig(
                digitBorderWidth: 2, primaryColor: Colors.blue),
            cancelButton: const Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
            digits: ['一', '二', '三', '四', '五', '六', '七', '八', '九', '零']);
      },
    );
  }

  _showLockScreen(
      BuildContext context, {
        required bool opaque,
        CircleUIConfig? circleUIConfig,
        KeyboardUIConfig? keyboardUIConfig,
        required Widget cancelButton,
        List<String>? digits,
      }) {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (context, animation, secondaryAnimation) =>
              PasscodeScreen(
                title: const Text(
                  '輸入應用密碼',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ),
                circleUIConfig: circleUIConfig,
                keyboardUIConfig: keyboardUIConfig,
                passwordEnteredCallback: _onPasscodeEntered,
                cancelButton: cancelButton,
                deleteButton: const Text(
                  '刪除',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  semanticsLabel: '刪除',
                ),
                shouldTriggerVerification: _verificationNotifier.stream,
                backgroundColor: Colors.black.withOpacity(0.8),
                cancelCallback: _onPasscodeCancelled,
                digits: digits,
                passwordDigits: 6,
                bottomWidget: _buildPasscodeRestoreButton(),
              ),
        ));
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = storedPasscode == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      setState(() {
        isAuthenticated = isValid;
      });
    }
  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  _buildPasscodeRestoreButton() => Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      margin: const EdgeInsets.only(bottom: 10.0, top: 20.0),
      child: TextButton(
        onPressed: _resetAppPassword,
        child: const Text(
          "重置密碼",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w300),
        ),
        // splashColor: Colors.white.withOpacity(0.4),
        // highlightColor: Colors.white.withOpacity(0.2),
        // ),
      ),
    ),
  );

  _resetAppPassword() {
    Navigator.maybePop(context).then((result) {
      if (!result) {
        return;
      }
      _showRestoreDialog(() {
        Navigator.maybePop(context);
        //TODO: Clear your stored passcode here
      });
    });
  }

  _showRestoreDialog(VoidCallback onAccepted) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "重置密碼",
            style: TextStyle(color: Colors.black87),
          ),
          content: const Text(
            "密碼重置是一項不安全的操作！\n\n如果執行此操作，請考慮刪除所有用戶數據.",
            style: TextStyle(color: Colors.black87),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: const Text(
                "取消",
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
            TextButton(
              onPressed: onAccepted,
              child: const Text(
                "我明白",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }
}