import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'highlight_map.dart';

class HighlightDemo extends StatefulWidget {
  const HighlightDemo({Key? key}) : super(key: key);

  @override
  _HighlightDemoState createState() => _HighlightDemoState();
}

class _HighlightDemoState extends State<HighlightDemo> {
  String language = 'dart';
  String theme = 'a11y-dark';

  Widget _buildMenuContent(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(children: <Widget>[
        Text(text, style: const TextStyle(fontSize: 16)),
        const Icon(Icons.arrow_drop_down)
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Highlight Demo'),
        actions: <Widget>[
          PopupMenuButton(
            child: _buildMenuContent(language),
            itemBuilder: (context) {
              return highlightMap.keys.map((key) {
                return CheckedPopupMenuItem(
                  value: key,
                  checked: language == key,
                  child: Text(key),
                );
              }).toList();
            },
            onSelected: (selected) {
              if (selected != null) {
                setState(() {
                  language = selected.toString();
                });
              }
            },
          ),
          PopupMenuButton<String>(
            child: _buildMenuContent(theme),
            itemBuilder: (context) {
              return themeMap.keys.map((key) {
                return CheckedPopupMenuItem(
                  value: key,
                  checked: theme == key,
                  child: Text(key),
                );
              }).toList();
            },
            onSelected: (selected) {
              if (selected != null) {
                setState(() {
                  theme = selected;
                });
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.code),
            tooltip: 'Source Code',
            onPressed: () {
              launch('https://github.com/pd4d10/highlight');
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            HighlightView(
              highlightMap[language]!,
              language: language,
              theme: themeMap[theme]!,
              padding: const EdgeInsets.all(12),
              textStyle: const TextStyle(
                  fontFamily:
                  'SFMono-Regular,Consolas,Liberation Mono,Menlo,monospace'),
            )
          ],
        ),
      ),
    );
  }
}