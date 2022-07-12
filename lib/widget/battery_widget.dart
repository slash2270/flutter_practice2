/*import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryWidget extends StatefulWidget {
  const BatteryWidget({Key? key}) : super(key: key);

  @override
  _BatteryWidgetState createState() => _BatteryWidgetState();
}

class _BatteryWidgetState extends State<BatteryWidget> {
  final Battery _battery = Battery();

  BatteryState? _batteryState;
  StreamSubscription<BatteryState>? _batteryStateSubscription;

  @override
  void initState() {
    super.initState();
    _battery.batteryState.then(_updateBatteryState);
    _batteryStateSubscription = _battery.onBatteryStateChanged.listen(_updateBatteryState);
  }

  void _updateBatteryState(BatteryState state) {
    if (_batteryState == state) return;
    setState(() {
      _batteryState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_batteryState'),
            ElevatedButton(
              onPressed: () async {
                final batteryLevel = await _battery.batteryLevel;
                // ignore: unawaited_futures
                showDialog<void>(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: Text('Battery: $batteryLevel%'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      )
                    ],
                  ),
                );
              },
              child: const Text('獲取電池電量'),
            ),
            ElevatedButton(
                onPressed: () async {
                  final isInPowerSaveMode = await _battery.isInBatterySaveMode;
                  // ignore: unawaited_futures
                  showDialog<void>(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: Text('處於低功耗模式: $isInPowerSaveMode'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        )
                      ],
                    ),
                  );
                },
                child: const Text('處於低功耗模式'))
          ],
        ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_batteryStateSubscription != null) {
      _batteryStateSubscription!.cancel();
    }
  }
}*/