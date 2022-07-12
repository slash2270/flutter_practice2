import 'package:flutter/material.dart';
import 'package:flutter_practice2/audio/audio_session_widget.dart';
import 'package:flutter_practice2/just_audio/just_waveform_widget.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:flutter_practice2/widget/chewie_audio_widget.dart';
import 'package:flutter_practice2/widget/share_plus_widget.dart';

import '../just_audio/just_audio_catching_widget.dart';
import '../just_audio/just_audio_radio_widget.dart';
import '../just_audio/just_audio_widget.dart';

class FifteenPage extends StatefulWidget {
  const FifteenPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FifteenPageState();
  }
}

class FifteenPageState extends State<FifteenPage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fifteen Page'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, Constants.routeHome);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Just Audio', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            const JustAudioWidget(),
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Catching', Constants.colorBlack, Constants.colorTransparent, 20),
            _functionUtil.initSizedBox(16.0),
            const JustAudioCatchingWidget(),
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Radio', Constants.colorBlack, Constants.colorTransparent, 20),
            const JustAudioRadioWidget(),
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Audio Session', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            const AudioSessionWidget(),
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Just Waveform', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            const JustWaveformWidget(),
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Chewie Audio', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            const ChewieAudioWidget(),
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Share Plus', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            const SharePlusWidget(),
            _functionUtil.initSizedBox(20.0),
          ],
        )
      ),
      resizeToAvoidBottomInset: false,
    );
  }

}