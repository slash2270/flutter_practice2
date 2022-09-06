import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import 'api_video_channel.dart';
import 'api_video_params.dart';
import 'api_video_resolution.dart';
import 'api_video_sample_rate.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key, required this.params}) : super(key: key);
  final ApiVideoParams params;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int resultAlert = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(
                context,
              );
            }),
      ),
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SettingsList(
            sections: [
              SettingsSection(
                title: const Text('影片'),
                tiles: [
                  SettingsTile(
                    title: const Text('解析度'),
                    value: Text(widget.params.getResolutionToString()),
                    onPressed: (BuildContext context) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return PickerScreen(
                                title: "選擇解析度",
                                initialValue: widget.params.video.resolution,
                                values: getResolutionsMap());
                          }).then((value) {
                        if (value != null) {
                          setState(() {
                            widget.params.video.resolution = value;
                          });
                        }
                      });
                    },
                  ),
                  SettingsTile(
                    title: const Text('偵率'),
                    value: Text(widget.params.video.fps.toString()),
                    onPressed: (BuildContext context) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return PickerScreen(
                                title: "選擇偵率",
                                initialValue:
                                widget.params.video.fps.toString(),
                                values: fpsList.toMap());
                          }).then((value) {
                        if (value != null) {
                          setState(() {
                            widget.params.video.fps = value;
                          });
                        }
                      });
                    },
                  ),
                  CustomSettingsTile(
                    child: Column(
                      children: [
                        SettingsTile(
                          title: const Text('比特率'),
                        ),
                        Row(
                          children: [
                            Slider(
                              value: (widget.params.video.bitrate / 1024)
                                  .toDouble(),
                              onChanged: (newValue) {
                                setState(() {
                                  widget.params.video.bitrate =
                                      (newValue.roundToDouble() * 1024)
                                          .toInt();
                                });
                              },
                              min: 500,
                              max: 10000,
                            ),
                            Text('${widget.params.video.bitrate}')
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SettingsSection(
                title: const Text('聲音'),
                tiles: [
                  SettingsTile(
                    title: const Text("通道數"),
                    value: Text(widget.params.getChannelToString()),
                    onPressed: (BuildContext context) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return PickerScreen(
                                title: "選擇頻道數量",
                                initialValue:
                                widget.params.getChannelToString(),
                                values: getVideoChannelsMap());
                          }).then((value) {
                        if (value != null) {
                          setState(() {
                            widget.params.audio.channel = value;
                          });
                        }
                      });
                    },
                  ),
                  SettingsTile(
                    title: const Text('比特率'),
                    value: Text(widget.params.getBitrateToString()),
                    onPressed: (BuildContext context) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return PickerScreen(
                                title: "選擇比特率",
                                initialValue:
                                widget.params.getChannelToString(),
                                values: audioBitrateList.toMap(
                                    valueTransformation: (int e) =>
                                        bitrateToPrettyString(e)));
                          }).then((value) {
                        if (value != null) {
                          setState(() {
                            widget.params.audio.bitrate = value;
                          });
                        }
                      });
                    },
                  ),
                  SettingsTile(
                    title: const Text('採樣率'),
                    value: Text(widget.params.getSampleRateToString()),
                    onPressed: (BuildContext context) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return PickerScreen(
                                title: "選擇樣本率",
                                initialValue:
                                widget.params.getSampleRateToString(),
                                values: getSampleRatesMap());
                          }).then((value) {
                        if (value != null) {
                          setState(() {
                            widget.params.audio.sampleRate = value;
                          });
                        }
                      });
                    },
                  ),
                  SettingsTile.switchTile(
                    title: const Text('啟用迴聲消除器'),
                    initialValue: widget.params.audio.enableEchoCanceler,
                    onToggle: (bool value) {
                      setState(() {
                        widget.params.audio.enableEchoCanceler = value;
                      });
                    },
                  ),
                  SettingsTile.switchTile(
                    title: const Text('啟用噪聲抑制器'),
                    initialValue: widget.params.audio.enableNoiseSuppressor,
                    onToggle: (bool value) {
                      setState(() {
                        widget.params.audio.enableNoiseSuppressor = value;
                      });
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: const Text('端點'),
                tiles: [
                  SettingsTile(
                      title: const Text('RTMP 端點'),
                      value: Text(widget.params.rtmpUrl),
                      onPressed: (BuildContext context) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return EditTextScreen(
                                  title: "輸入RTMP端點網址",
                                  initialValue: widget.params.rtmpUrl,
                                  onChanged: (value) {
                                    setState(() {
                                      widget.params.rtmpUrl = value;
                                    });
                                  });
                            });
                      }),
                  SettingsTile(
                      title: const Text('流金鑰'),
                      value: Text(widget.params.streamKey),
                      onPressed: (BuildContext context) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return EditTextScreen(
                                  title: "輸入流金鑰",
                                  initialValue: widget.params.streamKey,
                                  onChanged: (value) {
                                    setState(() {
                                      widget.params.streamKey = value;
                                    });
                                  });
                            });
                      }),
                ],
              )
            ],
          )),
    );
  }
}

class PickerScreen extends StatelessWidget {
  const PickerScreen({
    Key? key,
    required this.title,
    required this.initialValue,
    required this.values,
  }) : super(key: key);

  final String title;
  final dynamic initialValue;
  final Map<dynamic, String> values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text(title),
            tiles: values.keys.map((e) {
              final value = values[e];

              return SettingsTile(
                title: Text(value!),
                onPressed: (_) {
                  Navigator.of(context).pop(e);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class EditTextScreen extends StatelessWidget {
  const EditTextScreen(
      {Key? key,
        required this.title,
        required this.initialValue,
        required this.onChanged})
      : super(key: key);

  final String title;
  final String initialValue;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: SettingsList(
        sections: [
          SettingsSection(title: Text(title), tiles: [
            CustomSettingsTile(
              child: TextField(
                  controller: TextEditingController(text: initialValue),
                  onChanged: onChanged),
            ),
          ]),
        ],
      ),
    );
  }
}