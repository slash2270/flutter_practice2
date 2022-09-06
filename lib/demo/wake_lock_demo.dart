import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

class WakelockDemo extends StatefulWidget {

  const WakelockDemo({Key? key}) : super(key: key);

  @override
  _WakelockDemoState createState() => _WakelockDemoState();
}

class _WakelockDemoState extends State<WakelockDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Wakelock Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Spacer(
                flex: 3,
              ),
              OutlinedButton(
                onPressed: () {
                  // The following code will enable the wakelock on the device
                  // using the wakelock plugin.
                  setState(() {
                    Wakelock.enable();
                    // You could also use Wakelock.toggle(on: true);
                  });
                },
                child: const Text('啟用喚醒鎖'),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {
                  // The following code will disable the wakelock on the device
                  // using the wakelock plugin.
                  setState(() {
                    Wakelock.disable();
                    // You could also use Wakelock.toggle(on: false);
                  });
                },
                child: const Text('禁用喚醒鎖'),
              ),
              const Spacer(
                flex: 2,
              ),
              FutureBuilder(
                future: Wakelock.enabled,
                builder: (context, AsyncSnapshot<bool> snapshot) {
                  final data = snapshot.data;
                  // The use of FutureBuilder is necessary here to await the
                  // bool value from the `enabled` getter.
                  if (data == null) {
                    // The Future is retrieved so fast that you will not be able
                    // to see any loading indicator.
                    return Container();
                  }

                  return Text('喚醒鎖當前是 '
                      '${data ? '啟用' : '禁用'}.');
                },
              ),
              const Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}