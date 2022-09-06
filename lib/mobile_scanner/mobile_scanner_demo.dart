import 'package:flutter/material.dart';

import 'barcode_scanner_controller.dart';
import 'barcode_scanner_returning_image.dart';
import 'barcode_scanner_without_controller.dart';

class MobileScannerDemo extends StatelessWidget {
  const MobileScannerDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Scanner Demo')),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BarcodeScannerWithController(),
                  ),
                );
              },
              child: const Text('帶控制器的 MobileScanner'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BarcodeScannerReturningImage(),
                  ),
                );
              },
              child:
              const Text('帶控制器的 MobileScanner（返回圖像）'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                    const BarcodeScannerWithoutController(),
                  ),
                );
              },
              child: const Text('無控制器移動掃描儀'),
            ),
          ],
        ),
      ),
    );
  }
}