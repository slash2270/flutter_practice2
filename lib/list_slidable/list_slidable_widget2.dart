import 'package:flutter/material.dart';
import 'package:flutter_practice2/widget/passcode_screen_widget.dart';
import 'package:flutter_practice2/widget/scope_model_widget.dart';
import 'package:flutter_practice2/widget/scratcher_widget.dart';
import 'package:flutter_practice2/widget/sliding_up_panel_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../util/function_util.dart';

class ListSlidableWidget2 extends StatefulWidget {
  const ListSlidableWidget2({Key? key}) : super(key: key);

  @override
  State<ListSlidableWidget2> createState() => _ListSlidableWidget2State();
}

class _ListSlidableWidget2State extends State<ListSlidableWidget2> {

  late FunctionUtil _functionUtil;
  bool alive = true, _isSliding = false;

  @override
  void initState() {
  super.initState();
  _functionUtil = FunctionUtil();
  }

  @override
  Widget build(BuildContext context) {
    final direction = AppState.of(context)!.direction;
    return SlidableAutoCloseBehavior(
        child: ListView(
          scrollDirection: flipAxis(direction),
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Slidable(
                key: const ValueKey(1),
                groupTag: '0',
                direction: direction,
                startActionPane: const ActionPane(
                  openThreshold: 0.1,
                  closeThreshold: 0.4,
                  motion: BehindMotion(),
                  children: [
                    SlideAction(color: Colors.green, icon: Icons.share),
                    SlideAction(color: Colors.amber, icon: Icons.delete),
                  ],
                ),
                endActionPane: const ActionPane(
                  motion: BehindMotion(),
                  children: [
                    SlideAction(color: Colors.red, icon: Icons.delete_forever),
                    SlideAction(color: Colors.blue, icon: Icons.alarm, flex: 2),
                  ],
                ),
                child: const Tile(color: Colors.grey, text: 'hello'),
              ),
            ),
            Slidable(
              key: const ValueKey(2),
              groupTag: '0',
              direction: direction,
              startActionPane: const ActionPane(
                motion: StretchMotion(),
                children: [
                  SlideAction(color: Colors.green, icon: Icons.share),
                  SlideAction(color: Colors.amber, icon: Icons.delete),
                ],
              ),
              endActionPane: const ActionPane(
                motion: StretchMotion(),
                children: [
                  SlideAction(color: Colors.red, icon: Icons.delete_forever),
                  SlideAction(color: Colors.blue, icon: Icons.alarm, flex: 3),
                ],
              ),
              child: const Tile(color: Colors.pink, text: 'hello 2'),
            ),
            Slidable(
              key: const ValueKey(3),
              direction: direction,
              startActionPane: const ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlideAction(color: Colors.green, icon: Icons.share),
                  SlideAction(color: Colors.amber, icon: Icons.delete),
                ],
              ),
              endActionPane: const ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlideAction(color: Colors.red, icon: Icons.delete_forever),
                  SlideAction(color: Colors.blue, icon: Icons.alarm, flex: 2),
                ],
              ),
              child: const Tile(color: Colors.yellow, text: 'hello 3'),
            ),
            if (alive)
              Slidable(
                key: const ValueKey(4),
                direction: direction,
                startActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  dismissible: DismissiblePane(
                    onDismissed: () {
                      setState(() {
                        alive = false;
                      });
                    },
                    closeOnCancel: true,
                    confirmDismiss: () async {
                      return await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Are you sure?'),
                            content: const Text('Are you sure to dismiss?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: const Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text('No'),
                              ),
                            ],
                          );
                        },
                      ) ??
                          false;
                    },
                  ),
                  children: const [
                    SlideAction(color: Colors.green, icon: Icons.share),
                    SlideAction(color: Colors.amber, icon: Icons.delete),
                  ],
                ),
                endActionPane: const ActionPane(
                  motion: DrawerMotion(),
                  children: [
                    SlideAction(color: Colors.red, icon: Icons.delete_forever),
                    SlideAction(color: Colors.blue, icon: Icons.alarm, flex: 2),
                  ],
                ),
                child: const Tile(color: Colors.lime, text: 'hello 4'),
              ),
            Slidable(
              key: const ValueKey(5),
              direction: direction,
              startActionPane: const ActionPane(
                motion: BehindMotion(),
                children: [
                  SlideAction(color: Colors.green, icon: Icons.share),
                  SlideAction(color: Colors.amber, icon: Icons.delete),
                ],
              ),
              endActionPane: const ActionPane(
                motion: BehindMotion(),
                children: [
                  SlideAction(color: Colors.red, icon: Icons.delete_forever),
                  SlideAction(color: Colors.blue, icon: Icons.alarm, flex: 2),
                ],
              ),
              child: const Tile(color: Colors.grey, text: 'hello'),
            ),
            Slidable(
              key: const ValueKey(6),
              direction: direction,
              startActionPane: const ActionPane(
                motion: BehindMotion(),
                children: [
                  SlideAction(color: Colors.green, icon: Icons.share),
                  SlideAction(color: Colors.amber, icon: Icons.delete),
                ],
              ),
              endActionPane: const ActionPane(
                motion: BehindMotion(),
                children: [
                  SlideAction(color: Colors.red, icon: Icons.delete_forever),
                  SlideAction(color: Colors.blue, icon: Icons.alarm, flex: 2),
                ],
              ),
              child: const Tile(color: Colors.grey, text: 'hello'),
            ),
            Slidable(
              key: const ValueKey(7),
              direction: direction,
              startActionPane: const ActionPane(
                motion: BehindMotion(),
                children: [
                  SlideAction(color: Colors.green, icon: Icons.share),
                  SlideAction(color: Colors.amber, icon: Icons.delete),
                ],
              ),
              endActionPane: const ActionPane(
                motion: BehindMotion(),
                children: [
                  SlideAction(color: Colors.red, icon: Icons.delete_forever),
                  SlideAction(color: Colors.blue, icon: Icons.alarm, flex: 2),
                ],
              ),
              child: const Tile(color: Colors.grey, text: 'hello'),
            ),
            Slidable(
              key: const ValueKey(8),
              direction: direction,
              startActionPane: const ActionPane(
                motion: BehindMotion(),
                children: [
                  SlideAction(color: Colors.green, icon: Icons.share),
                  SlideAction(color: Colors.amber, icon: Icons.delete),
                ],
              ),
              endActionPane: const ActionPane(
                motion: BehindMotion(),
                children: [
                  SlideAction(color: Colors.red, icon: Icons.delete_forever),
                  SlideAction(color: Colors.blue, icon: Icons.alarm, flex: 2),
                ],
              ),
              child: const Tile(color: Colors.grey, text: 'hello'),
            ),
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Scope Model', Colors.black, Colors.transparent, 24),
            _functionUtil.initSizedBox(16.0),
            ScopeModelWidget(model: CounterModel()),
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Scratcher', Colors.black, Colors.transparent, 24),
            _functionUtil.initSizedBox(16.0),
            const ScratcherWidget(),
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Sliding Up Panel', Colors.black, Colors.transparent, 24),
            _functionUtil.initSizedBox(16.0),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    _isSliding = !_isSliding;
                  });
            },
                child: _functionUtil.initText('Sliding Up Panel'),
            ),
            Visibility(
              visible: _isSliding,
              child: const SlidingUpPanelWidget(),
            ),
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Passcode Screen', Colors.black, Colors.transparent, 24),
            _functionUtil.initSizedBox(16.0),
            const PassCodeScreenWidget(),
            _functionUtil.initSizedBox(20.0),
          ],
        ),
    );
  }
}

class SlideAction extends StatelessWidget {
  const SlideAction({
    Key? key,
    required this.color,
    required this.icon,
    this.flex = 1,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      flex: flex,
      backgroundColor: color,
      foregroundColor: Colors.white,
      onPressed: (_) {
        print(icon);
      },
      icon: icon,
      label: 'hello',
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    final direction = AppState.of(context)!.direction;
    return ActionTypeListener(
      child: GestureDetector(
        onTap: () {
          print('$text');
        },
        onLongPress: () => Slidable.of(context)!.openEndActionPane(),
        child: Container(
          color: color,
          height: direction == Axis.horizontal ? 100 : double.infinity,
          width: direction == Axis.horizontal ? double.infinity : 100,
          child: Center(child: Text(text)),
        ),
      ),
    );
  }
}

class ActionTypeListener extends StatefulWidget {
  const ActionTypeListener({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _ActionTypeListenerState createState() => _ActionTypeListenerState();
}

class _ActionTypeListenerState extends State<ActionTypeListener> {
  ValueNotifier<ActionPaneType>? _actionPaneTypeValueNotifier;

  @override
  void initState() {
    super.initState();
    _actionPaneTypeValueNotifier = Slidable.of(context)?.actionPaneType;
    _actionPaneTypeValueNotifier?.addListener(_onActionPaneTypeChanged);
  }

  @override
  void dispose() {
    _actionPaneTypeValueNotifier?.removeListener(_onActionPaneTypeChanged);
    super.dispose();
  }

  void _onActionPaneTypeChanged() {
    debugPrint('Value is ${_actionPaneTypeValueNotifier?.value}');
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class AppState extends InheritedWidget {
  const AppState({
    Key? key,
    required this.direction,
    required Widget child,
  }) : super(key: key, child: child);

  final Axis direction;

  @override
  bool updateShouldNotify(covariant AppState oldWidget) {
    return direction != oldWidget.direction;
  }

  static AppState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>();
  }
}