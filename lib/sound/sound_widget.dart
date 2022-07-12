import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/sound/sound_demo.dart';
import 'package:flutter_practice2/sound/sound_simple_play_back.dart';
import 'package:flutter_practice2/sound/sound_simple_recorder.dart';

const int tNotWeb = 1;

class Example {
  ///
  final String? title;

  ///
  final String? subTitle;

  ///
  final String? description;

  ///
  final WidgetBuilder? route;

  ///
  final int? flags;

  ///
  /* ctor */ Example(
      {this.title, this.subTitle, this.description, this.flags, this.route});

  ///
  void go(BuildContext context) =>
      Navigator.push(context, MaterialPageRoute<void>(builder: route!));
}

///
final List<Example> exampleTable = [
  // 如果您更新以下測試，請同時更新 Examples/README.md 文件和 dart 文件中的註釋.

  Example(
      title: 'Demo',
      subTitle: 'Flutter Sound capabilities',
      flags: 0,
      route: (_) => const SoundDemo(),
      description:
      '''這是一個關於 Flutter Sound 功能的演示。
這個演示應用程序的代碼不是那麼簡單，不幸的是不是很乾淨:-(。
Flutter Sound 初學者：你可能應該看看 `[SimplePlayback]` 和 `[SimpleRecorder]`
這個 Demo 最大的興趣在於它展示了 Flutter Sound 的大部分功能：
- 使用各種編解碼器從各種媒體播放
- 使用各種編解碼器記錄到各種媒體
- 暫停和恢復錄製或播放控制
- 展示如何使用 Stream 獲取播放（或重新編碼）事件
- 展示瞭如何在播放終止時指定回調函數，
- 展示如何錄製到流或從流中回放
- 可以在 iOS 或 Android 鎖屏上顯示控件
- ...
這個 Demo 沒有使用 Flutter Sound UI Widgets。
如果有人能盡快重寫這個演示，那就太好了'''),

  Example(
    title: 'simplePlayback',
    subTitle: 'A very simple example',
    flags: 0,
    route: (_) => const SoundSimplePlayback(),
    description: '''
這是一個非常簡單的 Flutter Sound 初學者示例，
這顯示瞭如何播放遠程文件。
這個例子真的很基礎。
''',
  ),

  Example(
    title: 'simpleRecorder',
    subTitle: 'A very simple example',
    flags: 0,
    route: (_) => const SoundSimpleRecorder(),
    description: '''
這是一個非常簡單的 Flutter Sound 初學者示例，
這顯示瞭如何錄製，然後播放文件。
這個例子真的很基礎。
''',
  ),

  /*Example(
    title: 'multiPlayback',
    subTitle: 'Playing several sound at the same time',
    flags: 0,
    route: (_) => MultiPlayback(),
    description: '''
This is a simple example that plays several sound at the same time.
''',
  ),

  Example(
    title: 'Volume Control',
    subTitle: 'Volume Control',
    flags: 0,
    route: (_) => VolumeControl(),
    description: '''
This is a very simple example showing how to set the Volume during a playback.
This example is really basic.
''',
  ),

  Example(
    title: 'Speed Control',
    subTitle: 'Speed Control',
    flags: 0,
    route: (_) => SpeedControl(),
    description: '''
This is a very simple example showing how tune the speed of a playback.
This example is really basic.
''',
  ),

  Example(
    title: 'Seek Player',
    subTitle: 'Seek Player',
    flags: 0,
    route: (_) => Seek(),
    description: '''
This is a very simple example showing how tune the speed of a playback.
This example is really basic.
''',
  ),

  Example(
    title: 'Player onProgress',
    subTitle: 'Player onProgress',
    flags: 0,
    route: (_) => PlayerOnProgress(),
    description: '''
This is a very simple example showing how to  call `setSubscriptionDuration() and use onProgress() on a player.
''',
  ),

  Example(
    title: 'Recorder onProgress',
    subTitle: 'Recorder onProgress',
    flags: 0,
    route: (_) => RecorderOnProgress(),
    description: '''
This is a very simple example showing how to  call `setSubscriptionDuration() and use onProgress() on a recorder.
''',
  ),

  Example(
    title: 'Play from Mic',
    subTitle: 'Play from microphone',
    flags: tNotWeb,
    route: (_) => PlayFromMic(),
    description: '''
Play on the bluetooth headset what is recorded by the microphone.
This example is very simple.
>>> Please ensure that your headset is correctly connected via bluetooth
''',
  ),

  Example(
    title: 'recordToStream',
    subTitle: 'Example of recording to Stream',
    flags: tNotWeb,
    route: (_) => RecordToStreamExample(),
    description: '''
This is an example showing how to record to a Dart Stream.
It writes all the recorded data from a Stream to a File, which is completely stupid:
if an App wants to record something to a File, it must not use Streams.
The real interest of recording to a Stream is for example to feed a Speech-to-Text engine, or for processing the Live data in Dart in real time.
''',
  ),

  Example(
    title: 'livePlaybackWithoutBackPressure',
    subTitle: 'Live Playback without BackPressure',
    flags: tNotWeb,
    route: (_) => LivePlaybackWithoutBackPressure(),
    description:
    '''A very simple example showing how to play Live Data without back pressure.
A very simple example showing how to play Live Data without back pressure.
It feeds a live stream, without waiting that the Futures are completed for each block.
This is simpler because the App does not need to await the playback for each block before playing another one.
This example get the data from an asset file, which is completely stupid :
if an App wants to play an asset file he must use "StartPlayerFromBuffer().
Feeding Flutter Sound without back pressure is very simple but you can have two problems :
- If your App is too fast feeding the audio channel, it can have problems with the Stream memory used.
- The App does not have any knowledge of when the provided block is really played.
If he does a "stopPlayer()" it will loose all the buffered data.
This example uses the ```foodEvent``` object to resynchronize the output stream before doing a ```stop()```
''',
  ),

  Example(
    title: 'livePlaybackWithBackPressure',
    subTitle: 'Live Playback with BackPressure',
    flags: tNotWeb,
    route: (_) => LivePlaybackWithBackPressure(),
    description: '''
A very simple example showing how to play Live Data with back pressure.
It feeds a live stream, waiting that the Futures are completed for each block.
This example get the data from an asset file, which is completely stupid :
if an App wants to play an asset file he must use "StartPlayerFromBuffer().
If you do not need any back pressure, you can see another simple example : "LivePlaybackWithoutBackPressure.dart".
This other example is a little bit simpler because the App does not need to await the playback for each block before
playing another one.
''',
  ),

  Example(
    title: 'soundEffect',
    subTitle: 'Sound Effect',
    flags: tNotWeb,
    route: (_) => SoundEffect(),
    description: '''
```startPlayerFromStream()``` can be very efficient to play sound effects. For example in a game App.
The App open the Audio Session and call ```startPlayerFromStream()``` during initialization.
When it want to play a noise, it has just to call the verb ```feed```
''',
  ),

  Example(
    title: 'streamLoop',
    subTitle: 'Loop from recorder to player',
    flags: tNotWeb,
    route: (_) => StreamLoop(),
    description: '''
```streamLoop()``` is a very simple example which connect the FlutterSoundRecorder sink
to the FlutterSoundPlayer Stream.
Of course, we do not play to the loudspeaker to avoid a very unpleasant Larsen effect.
This example does not use a new StreamController, but use directly `foodStreamController`
from flutter_sound_player.dart.
''',
  ),

  Example(
    title: 'setLogLevel()',
    subTitle: 'Dynamically change the log level',
    flags: 0,
    route: (_) => LogLevel(),
    description: '''
```
Shows how to change the loglevel during an audio session.
''',
  ),

  Example(
    title: 'StreamLoopJustAudio()',
    subTitle: 'JustAudio cohabitation',
    flags: tNotWeb,
    route: (_) => StreamLoopJustAudio(),
    description: '''
    ```
    Test the StreamLoop with JustAudio cohabitation.
    ''',
  ),*/
];

class SoundWidget extends StatefulWidget {
  const SoundWidget({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _SoundWidgetState createState() => _SoundWidgetState();
}

class _SoundWidgetState extends State<SoundWidget> {
  Example? selectedExample;

  @override
  void initState() {
    selectedExample = exampleTable[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget cardBuilder(BuildContext context, int index) {
      var isSelected = (exampleTable[index] == selectedExample);
      return GestureDetector(
        onTap: () => setState(() {
          selectedExample = exampleTable[index];
        }),
        child: Card(
          shape: const RoundedRectangleBorder(),
          borderOnForeground: false,
          elevation: 3.0,
          child: Container(
            height: 50,
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: isSelected ? Colors.indigo : const Color(0xFFFAF0E6),
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
            ),

            //color: isSelected ? Colors.indigo : Colors.cyanAccent,
            child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(exampleTable[index].title!,
                  style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
              Text(exampleTable[index].subTitle!,
                  style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
            ]),
          ),
        ),
      );
    }

    Widget makeBody() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(3),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF0E6),
                border: Border.all(
                  color: Colors.indigo,
                  width: 3,
                ),
              ),
              child: ListView.builder(
                  itemCount: exampleTable.length, itemBuilder: cardBuilder),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(3),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF0E6),
                border: Border.all(
                  color: Colors.indigo,
                  width: 3,
                ),
              ),
              child: SingleChildScrollView(
                child: Text(selectedExample!.description!),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      body: makeBody(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFAF0E6),
              border: Border.all(
                color: Colors.indigo,
                width: 3,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text((kIsWeb && (selectedExample!.flags! & tNotWeb != 0))
                    ? 'Not supported on Flutter Web '
                    : ''),
                ElevatedButton(
                  onPressed:
                  (kIsWeb && (selectedExample!.flags! & tNotWeb != 0))
                      ? null
                      : () => selectedExample!.go(context),
                  //color: Colors.indigo,
                  child: const Text(
                    'GO',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )),
      ),
    );
  }
}