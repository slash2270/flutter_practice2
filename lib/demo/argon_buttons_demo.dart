import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ArgonButtonDemo extends StatelessWidget {
  const ArgonButtonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ArgonTimerButton(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.45,
              minWidth: MediaQuery.of(context).size.width * 0.30,
              highlightColor: Colors.transparent,
              highlightElevation: 0,
              roundLoadingShape: false,
              onTap: (startTimer, btnState) {
                if (btnState == ButtonState.Idle) {
                  startTimer(5);
                }
              },
              loader: (timeLeft) {
                return Text(
                  "等候 | $timeLeft",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                );
              },
              borderRadius: 5.0,
              color: Colors.transparent,
              elevation: 0,
              borderSide: BorderSide(color: Colors.black, width: 1.5),
              // initialTimer: 10,
              child: const Text(
                "Resend OTP",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ArgonTimerButton(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.45,
              onTap: (startTimer, btnState) {
                if (btnState == ButtonState.Idle) {
                  startTimer(5);
                }
              },
              loader: (timeLeft) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  margin: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  width: 40,
                  height: 40,
                  child: Text(
                    "$timeLeft",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                );
              },
              borderRadius: 5.0,
              color: const Color(0xFF7866FE),
              child: const Text(
                "重新發送一次性密碼",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ArgonTimerButton(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.45,
              minWidth: MediaQuery.of(context).size.width * 0.30,
              highlightColor: Colors.transparent,
              highlightElevation: 0,
              roundLoadingShape: false,
              splashColor: Colors.transparent,
              onTap: (startTimer, btnState) {
                if (btnState == ButtonState.Idle) {
                  startTimer(5);
                }
              },
              loader: (timeLeft) {
                return Text(
                  "候時 | $timeLeft",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                );
              },
              borderRadius: 5.0,
              color: Colors.transparent,
              elevation: 0,
              // initialTimer: 10,
              child: const Text(
                "重新發送一次性密碼",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              height: 1,
              color: Colors.black,
            ),
            const SizedBox(
              height: 50,
            ),
            ArgonButton(
              height: 50,
              roundLoadingShape: true,
              width: MediaQuery.of(context).size.width * 0.45,
              onTap: (startLoading, stopLoading, btnState) {
                if (btnState == ButtonState.Idle) {
                  startLoading();
                } else {
                  stopLoading();
                }
              },
              loader: Container(
                padding: const EdgeInsets.all(10),
                child: const SpinKitRotatingCircle(
                  color: Colors.white,
                  // size: loaderWidth ,
                ),
              ),
              borderRadius: 5.0,
              color: const Color(0xFFfb4747),
              child: const Text(
                "註冊",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ArgonButton(
              height: 50,
              roundLoadingShape: false,
              width: MediaQuery.of(context).size.width * 0.45,
              minWidth: MediaQuery.of(context).size.width * 0.30,
              onTap: (startLoading, stopLoading, btnState) {
                if (btnState == ButtonState.Idle) {
                  startLoading();
                } else {
                  stopLoading();
                }
              },
              loader: const Text(
                "載入中...",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              borderRadius: 5.0,
              color: const Color(0xFF7866FE),
              child: const Text(
                "待續",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}