import 'dart:convert';

import 'package:filesize/filesize.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/api_video/api_video_demo.dart';
import 'package:flutter_practice2/demo/wake_lock_demo.dart';
import 'package:flutter_practice2/image_compress/image_compress_demo.dart';
import 'package:flutter_practice2/sqlflite/sqlflite_demo.dart';
import 'package:flutter_practice2/video_compress/video_compress_demo.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../facebook/facebook_livevideos_bean.dart';
import '../livekit/connect_page.dart';
import '../twitch/twitch_authorize_bean.dart';
import '../twitch/twitch_stream_key_bean.dart';
import '../twitch/twitch_users_data_bean.dart';
import '../util/catch_util.dart';
import '../util/constants.dart';
import '../util/function_util.dart';

class FortyTwoPage extends StatefulWidget {
  const FortyTwoPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FortyTwoPageState();
  }
}

class FortyTwoPageState extends State<FortyTwoPage> {

  late FunctionUtil _functionUtil;
  late SharedPreferences _sP;
  ValueNotifier<int> cacheSize = ValueNotifier(0);
  String _facebookToken = 'facebookToken', _facebookUrl = 'facebookUrl', _twitchToken = 'twitchToken', _twitchUrl = 'twitchUrl';
  bool _isClear = false;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    _init();
    _getSp();
    _getFacebookStreamUrl();
    _getTwitchAuthorize();
    super.initState();
  }

  @override
  void dispose() {
    _sP.clear();
    super.dispose();
  }

  _init() { // 配置調試日誌
    Logger.root.level = Level.FINE;
    Logger.root.onRecord.listen((record) => LogUtil.e('${DateFormat('HH:mm:ss').format(record.time)}: ${record.message}'));
  }

  void _getSp() async{
    _sP = await SharedPreferences.getInstance();
    setState(() => _facebookToken = _sP.getString('facebook_token')!);
    LogUtil.e('Facebook Live token: $_facebookToken');
  }

  Future<void> _getFacebookStreamUrl() async{
    var uri = Uri.parse('${Constants.facebookApi}v14.0/${Constants.facebookID}/live_videos');
    var headers = {
      "broadcast_status" : "LIVE",
      "access_token": _facebookToken,
    };
    Response response = await http.get(uri, headers: headers);
    var jsonResponse = json.decode(response.body);
    // LogUtil.e('Facebook Live response1: $jsonResponse');
    //https://graph.facebook.com/v3.3/me/live_videos?status=LIVE_NOW&access_token={access-token}
    uri = Uri.parse('${Constants.facebookApi}v3.3/me/live_videos');
    //var uri = Uri.parse('https://graph.facebook.com/v3.3/me/live_videos');
    headers = {
      "status" : "LIVE_NOW",
      "access_token" : _facebookToken,
    };
    response = await http.post(uri, headers: headers, body: headers);
    jsonResponse = json.decode(response.body);
    // LogUtil.e('Facebook Live response2: $jsonResponse');
    FacebookLiveVideosBean liveVideosBean = FacebookLiveVideosBean.fromJson(jsonResponse);
    setState(() => _facebookUrl = liveVideosBean.secure_stream_url ?? '');
  }

  Future<void> _getTwitchAuthorize() async{
    final uri = Uri.parse(Constants.twitchApi1 + Constants.twitchTokenApi);
    final headers = {
      "Content-Type" :"application/x-www-form-urlencoded",
    };
    final body = {
      "client_id" : Constants.twitchID,
      "client_secret" : Constants.twitchPW,
      "grant_type" : 'client_credentials',
    };
    Response response = await http.post(uri, headers: headers, body: body);
    final jsonResponse = json.decode(response.body);
    // LogUtil.e('Twitch Authorize response: $jsonResponse');
    TwitchAuthorizeBean twitchAuthorizeBean = TwitchAuthorizeBean.fromJson(jsonResponse);
    setState(() => _twitchToken = twitchAuthorizeBean.access_token);
    // LogUtil.e('Twitch Authorize token: $_twitchToken');
    _getTwitchStreamKey(_twitchToken);
    _getTwitchUsers(_twitchToken);
  }

  Future<void> _getTwitchStreamKey(String token) async{
    var uri = Uri.parse('${Constants.twitchApi2}${Constants.twitchStreamKeyApi}${Constants.twitchChannelName}');
    final headers = {
      'Authorization' : '${Constants.twitchAuthHeader} $token',
      'Client-Id' : Constants.twitchID,
    };
    Response response = await http.get(uri, headers: headers);
    final jsonResponse = json.decode(response.body);
    LogUtil.e('Twitch StreamKey response: $jsonResponse');
    TwitchStreamKeyDataBean twitchStreamKeyDataBean = TwitchStreamKeyDataBean.fromJson(jsonResponse);
    TwitchStreamKeyBean twitchStreamKeyBean = twitchStreamKeyDataBean.data.first;
    final sP = await SharedPreferences.getInstance();
    sP.setString('twitch_streamKey', twitchStreamKeyBean.stream_key);
    LogUtil.e('Twitch StreamKey key: ${twitchStreamKeyBean.stream_key}');
    // setState(() => _twitchUrl += twitchStreamKeyBean.stream_key);
  }

  Future<void> _getTwitchUsers(String token) async{
    var uri = Uri.parse(Constants.twitchApi2 + Constants.twitchUserApi);
    final headers = {
      'Authorization' : '${Constants.twitchAuthHeader} $token',
      'Client-Id' : Constants.twitchID,
    };
    Response response = await http.get(uri, headers: headers);
    final jsonResponse = json.decode(response.body);
    // LogUtil.e('Twitch Users response: $jsonResponse');
    TwitchUsersDataBean twitchUsersDataBean = TwitchUsersDataBean.fromJson(jsonResponse);
    TwitchUsersBean twitchUsersBean = twitchUsersDataBean.data.first;
  }

  @override
  Widget build(BuildContext context) {
    _twitchUrl = '${Constants.twitchStreamRtmp2}${Constants.twitchStaticKey}';
    final sliverImageCompress = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('ImageCompress 圖片壓縮', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'Image Compress', const ImageCompressDemo()),
          ],
        )
    );
    final sliverVideoCompress = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('VideoCompress 影片壓縮', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'Video Compress', const VideoCompressDemo()),
          ],
        )
    );
    final sliverFacebook = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('FacebookApi 串接Live', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'Facebook Stream', ConnectPage(token: _facebookToken, url: _facebookUrl)),
          ],
        )
    );
    final sliverTwitch = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('TwitchApi 串接Live', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'Twitch Stream', ConnectPage(token: _twitchToken, url: _twitchUrl)),
          ],
        )
    );
    final sliverApiVideo = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('ApiVideo Rtmp直播流', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'Api Video', const ApiVideoDemo()),
          ],
        )
    );
    final sliverVideoStream = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('WakeLock 喚醒鎖', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'WakeLock', const WakelockDemo()),
          ],
        )
    );
    final sliverCatch = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Cache 緩存', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            ElevatedButton(
              onPressed:() => _setDialog(context),
              child: _functionUtil.initText2('Cache', Colors.white, Colors.transparent, 20),
            ),
          ],
        )
    );
    final sliverDb = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('SqlFLite 本機資料庫', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'SQL', const SqlFLiteDemo()),
          ],
        )
    );
    // final sliverLive = SliverToBoxAdapter(
    //     child: Column(
    //       children: [
    //         _functionUtil.initSizedBox(20.0),
    //         _functionUtil.initText2('Live RTMP/HTTP-FLV/HLS/WebRTC', Constants.colorBlack, Constants.colorTransparent, 24),
    //         _functionUtil.initSizedBox(16.0),
    //         _functionUtil.initElevatedButton(context, 'Live', Platform.isAndroid ? const Privacy() : const Home(),),
    //       ],
    //     )
    // );
    return Scaffold(
      appBar: AppBar(
        title: const Text('FortyTwo Page'),
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
      body: CustomScrollView(
        slivers: [
          sliverImageCompress,
          sliverVideoCompress,
          sliverFacebook,
          sliverTwitch,
          sliverApiVideo,
          sliverVideoStream,
          sliverCatch,
          sliverDb,
          // sliverLive,
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  _setDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, //控制點擊對話框以外的區域是否隱藏對話框
      builder: (BuildContext context) {
        initCache();
        return ValueListenableBuilder(
          valueListenable: cacheSize,
          builder: (BuildContext context, int size, Widget? _) {
            return AlertDialog(
              title: _functionUtil.initText('本機緩存'),
              content: SizedBox(
                height: 100,
                child: Column(
                  children: [
                    _isClear && size > 0 ? const CircularProgressIndicator(): _functionUtil.initText2(size > 0 ? '文件大小為:${filesize(size)}' : '本機無緩存', Colors.green, Colors.transparent, 18),
                    _functionUtil.initText2(_isClear && size > 0 ? '清除中 請稍候...' : '點擊清除緩存，但不會清除已下载的媒體', Colors.black, Colors.transparent, 18),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: _functionUtil.initText('取消'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: _functionUtil.initText('確定'),
                  onPressed: () {
                    setState(() => _isClear = true);
                    handleClearCache();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> initCache() async {
    /// 获取缓存大小
    int size = await CacheUtil.total();
    /// 复制变量
    cacheSize.value = size ?? 0;
  }

  Future<void> handleClearCache() async {
    try {
      if (cacheSize.value <= 0) {
        showToast('没有缓存可清理', position: ToastPosition.bottom);
        return;
      }
        /// 给予适当的提示
        /// bool confirm = await showDialog();
        /// if (confirm != true) return;
        /// 执行清除缓存
        await CacheUtil.clear();
        /// 更新缓存
        await initCache();
        setState(() => _isClear = false);
        showToast('缓存清除成功', position: ToastPosition.bottom);
    } catch (e) {
      showToast(e.toString());
    }
  }

}