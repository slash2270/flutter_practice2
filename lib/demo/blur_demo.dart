import 'package:flutter/material.dart';
import 'package:blur/blur.dart';

class BlurDemo extends StatefulWidget {
  const BlurDemo({Key? key}) : super(key: key);

  @override
  _BlurDemoState createState() => _BlurDemoState();
}

class _BlurDemoState extends State<BlurDemo> {
  double blurValue = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blur Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Image.asset('assets/beach.jpeg').blurred(
                    blur: blurValue,
                    blurColor: theme.primaryColor,
                    borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(20)),
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Image.asset('assets/beach.jpeg').blurred(
                    colorOpacity: 0.2,
                    borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(20)),
                    blur: blurValue,
                    overlay: Text(
                      'Cat',
                      style: theme.textTheme.headline2!
                          .copyWith(color: theme.scaffoldBackgroundColor),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/beach.jpeg',
                      scale: 3.5,
                    ),
                    Column(
                      children: [
                        const Icon(Icons.image),
                        Text(
                          'Frost',
                          style: theme.textTheme.headline4,
                        ),
                      ],
                    ).frosted(
                      blur: blurValue,
                      borderRadius: BorderRadius.circular(20),
                      padding: const EdgeInsets.all(8),
                    )
                  ],
                ),
                Blur(
                  blur: blurValue,
                  blurColor: theme.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Blur',
                      style: theme.textTheme.headline3,
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/beach.jpeg',
                  width: MediaQuery.of(context).size.width - 40,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Frost text',
                      style: theme.textTheme.headline3,
                    ).frosted(
                      blur: blurValue,
                      padding: const EdgeInsets.all(8),
                    ),
                    const SizedBox(width: 20),
                    const Icon(Icons.image).frosted(
                      padding: const EdgeInsets.all(8),
                      blur: blurValue,
                    ),
                  ],
                ),
              ],
            ),
            Slider(
              value: blurValue,
              max: 20,
              onChanged: (double value) {
                setState(() {
                  blurValue = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}