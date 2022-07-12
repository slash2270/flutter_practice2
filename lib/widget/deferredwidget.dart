// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:flutter/material.dart';

typedef LibraryLoader = Future<void> Function();
typedef DeferredWidgetBuilder = Widget Function();

/// 將子組件包裝在延遲的模塊加載器中。
///
/// 子元素被創建並在其中維護一個 Widget 實例
/// 狀態只要創建小部件的閉包保持不變。
class DeferredWidget extends StatefulWidget {
  DeferredWidget(
      this.libraryLoader,
      this.createWidget, {
        Key? key,
        Widget? placeholder,
      }) : placeholder = placeholder ?? Container(), super(key: key);

  final LibraryLoader libraryLoader;
  final DeferredWidgetBuilder createWidget;
  final Widget placeholder;
  static final Map<LibraryLoader, Future<void>> _moduleLoaders = {};
  static final Set<LibraryLoader> _loadedModules = {};

  static Future<void> preload(LibraryLoader loader) {
    if (!_moduleLoaders.containsKey(loader)) {
      _moduleLoaders[loader] = loader().then((dynamic _) {
        _loadedModules.add(loader);
      });
    }
    return _moduleLoaders[loader]!;
  }

  @override
  State<DeferredWidget> createState() => _DeferredWidgetState();
}

class _DeferredWidgetState extends State<DeferredWidget> {
  _DeferredWidgetState();

  Widget? _loadedChild;
  DeferredWidgetBuilder? _loadedCreator;

  @override
  void initState() {
    /// 如果模塊已經加載，立即創建小部件而不是
    /// 等待未來或區域轉彎。
    if (DeferredWidget._loadedModules.contains(widget.libraryLoader)) {
      _onLibraryLoaded();
    } else {
      DeferredWidget.preload(widget.libraryLoader)
          .then((dynamic _) => _onLibraryLoaded());
    }
    super.initState();
  }

  void _onLibraryLoaded() {
    setState(() {
      _loadedCreator = widget.createWidget;
      _loadedChild = _loadedCreator!();
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 如果創建小部件的閉包發生變化，則創建新實例，否則
    /// 視為 const Widget。
    if (_loadedCreator != widget.createWidget && _loadedCreator != null) {
      _loadedCreator = widget.createWidget;
      _loadedChild = _loadedCreator!();
    }
    return _loadedChild ?? widget.placeholder;
  }
}

/// 顯示進度指示器和文字說明
/// 小部件是一個延遲組件，當前正在安裝。
class DeferredLoadingPlaceholder extends StatelessWidget {
  const DeferredLoadingPlaceholder({
    Key? key,
    this.name = 'This widget',
  }): super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[700],
            border: Border.all(
              width: 20,
              color: Colors.grey[700]!,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        width: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('$name 正在安裝',
                style: Theme.of(context).textTheme.headline4),
            Container(height: 10),
            Text('$name 是在運行時下載和安裝的延遲組件',
                style: Theme.of(context).textTheme.bodyText1),
            Container(height: 20),
            const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}