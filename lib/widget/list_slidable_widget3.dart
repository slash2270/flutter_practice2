import 'dart:async';

import 'package:before_after/before_after.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_practice2/model/model_view.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:flutter_practice2/widget/battery_widget.dart';
import 'package:flutter_practice2/widget/install_plugin_widget.dart';
import 'package:flutter_practice2/widget/like_button_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../util/constants.dart';

const actions = [
  SlideAction(
    color: Color(0xFFFE4A49),
    icon: Icons.delete,
    label: 'Delete',
  ),
  SlideAction(
    color: Color(0xFF21B7CA),
    icon: Icons.share,
    label: 'Share',
  ),
];

class ListSlidableWidget3 extends StatefulWidget {
  const ListSlidableWidget3({Key? key,}) : super(key: key);

  @override
  _ListSlidableWidget3State createState() => _ListSlidableWidget3State();
}

class _ListSlidableWidget3State extends State<ListSlidableWidget3> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  late FunctionUtil _functionUtil;
  late bool _isCheckBox = false, _isSwitch = false;
  late int _indexToggle = 1;
  late double _sliderValue = 0, _progressPercent = 0;
  late Timer _timer;
  late IconData _iconData;

  @override
  void initState() {
    super.initState();
    _functionUtil = FunctionUtil();
    controller = AnimationController(
      vsync: this,
      upperBound: 0.5,
      duration: const Duration(milliseconds: 2000),
    );
    _setProgress();
    _setIcon();
  }

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      body: SlidablePlayer(
        animation: controller,
        child: SliverFixedExtentList(
          itemExtent: 50.0,
          delegate: SliverChildListDelegate([
            const SizedBox(height: 20),
            const MySlidable(motion: BehindMotion()),
            const MySlidable(motion: StretchMotion()),
            const MySlidable(motion: ScrollMotion()),
            const MySlidable(motion: DrawerMotion()),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller!.isCompleted) {
            controller!.reverse();
          } else if (controller!.isDismissed) {
            controller!.forward();
          }
        },
        child: _setIcon(),
      ),
    );*/
     return Scaffold(
       // 一个不需要GlobalKey就可以openDrawer的AppBar
       appBar: AppBar(
         title: const Text('Nine Page'),
         centerTitle: true,
         actions: <Widget>[
           IconButton(
             icon: const Icon(Icons.settings),
             onPressed: () {
               if (controller!.isCompleted) {
                 controller!.reverse();
               } else if (controller!.isDismissed) {
                 controller!.forward();
               }
               Navigator.pushNamed(context, Constants.routeHome);
             },
           ),
           IconButton(
             icon: Icon(_iconData),
             onPressed: () {
               if (controller!.isCompleted) {
                 controller!.reverse();
               } else if (controller!.isDismissed) {
                 controller!.forward();
               }
             },
           ),
         ],
       ),
       body: SlidablePlayer(
           animation: controller,
           child: ListView(
             children: [
               _functionUtil.initSizedBox(20.0),
               const MySlidable(motion: BehindMotion()),
               const MySlidable(motion: StretchMotion()),
               const MySlidable(motion: ScrollMotion()),
               const MySlidable(motion: DrawerMotion()),
               _functionUtil.initSizedBox(20.0),
               _functionUtil.initText2('Neumorphic 神經擬態', Colors.black, Colors.transparent, 24),
               _functionUtil.initSizedBox(20.0),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   _setNeumorphicButton('Concave', NeumorphicShape.concave),
                   _setNeumorphicButton('Convex', NeumorphicShape.convex),
                   _setNeumorphicButton('Flat', NeumorphicShape.flat),
                 ],
               ),
               _functionUtil.initSizedBox(16.0),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   _setNeumorphicText('ideographic', TextBaseline.ideographic),
                   _setNeumorphicText('alphabetic', TextBaseline.alphabetic),
                 ],
               ),
               _functionUtil.initSizedBox(16.0),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   _setNeumorphicIcon(Icons.heart_broken, 40.0),
                   _setNeumorphicIcon(Icons.heart_broken_outlined, 40.0),
                   _setNeumorphicIcon(Icons.monitor_heart, 40.0),
                   _setNeumorphicIcon(Icons.monitor_heart_outlined, 40.0),
                 ],
               ),
               _functionUtil.initSizedBox(16.0),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   _setNeumorphicRadio(0),
                   _setNeumorphicCheckBox(),
                   _setNeumorphicSwitch(),
                 ],
               ),
               _functionUtil.initSizedBox(16.0),
               _functionUtil.initText2('SliderValue: $_sliderValue', Colors.black, Colors.transparent, 18),
               _setNeumorphicSlider(),
               _functionUtil.initSizedBox(16.0),
               _functionUtil.initText2('ProgressPercent: $_progressPercent%', Colors.black, Colors.transparent, 18),
               _setNeumorphicProgress(),
               _functionUtil.initSizedBox(16.0),
               _setNeumorphicBackground(),
               _functionUtil.initSizedBox(20.0),
               _functionUtil.initText2('BeforeAfter', Colors.black, Colors.transparent, 24),
               _functionUtil.initSizedBox(16.0),
               Container(
                 color: Colors.black,
                 child: BeforeAfter(
                   beforeImage: Image.asset('assets/after.png'),
                   afterImage: Image.asset('assets/before.png'),
                 ),
               ),
               _functionUtil.initSizedBox(16.0),
               Container(
                 color: Colors.black,
                 child: BeforeAfter(
                   beforeImage: Image.asset('assets/after.jpg'),
                   afterImage: Image.asset('assets/before.jpg'),
                 ),
               ),
               _functionUtil.initSizedBox(20.0),
               _functionUtil.initText2('LikeButton', Colors.black, Colors.transparent, 24),
               _functionUtil.initSizedBox(16.0),
               LikeButtonWidget(),
               _functionUtil.initSizedBox(20.0),
               //_functionUtil.initText2('InstallPlugin', Colors.black, Colors.transparent, 24),
               //_functionUtil.initSizedBox(16.0),
               //InstallPluginWidget(),
             ],
           ),
         /*floatingActionButton: FloatingActionButton(
           onPressed: () {
             if (controller!.isCompleted) {
               controller!.reverse();
             } else if (controller!.isDismissed) {
               controller!.forward();
             }
           },
           child: _setIcon(),
         ),*/
       ),
       resizeToAvoidBottomInset: false,
     );
  }

  _setIcon(){
    _iconData = Icons.motion_photos_on;
    setState(() {
      if (controller!.isCompleted) {
        _iconData = Icons.motion_photos_off;
      } else if (controller!.isDismissed) {
        _iconData = Icons.motion_photos_on;
      }
    });
  }

  Widget _setNeumorphic(Widget child) {
    return _functionUtil.initPadding(
      8.0, 0.0, 8.0, 0.0,
      Slidable(
        startActionPane: const ActionPane(
          motion: BehindMotion(),
          children: actions,
        ),
        child: SlidableControllerSender(
          child: Container(
            color: Colors.grey.shade400,
            height: 100.0,
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _setNeumorphicButton(String title, NeumorphicShape shape){
    return Neumorphic(
      style: NeumorphicStyle(
          shape: shape,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          depth: 8,
          intensity: 20,
          lightSource: LightSource.topLeft,
          color: Colors.grey.shade300
      ),
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
        child: _functionUtil.initText2(title, Colors.white, Colors.transparent, 20),
        onPressed: (){},
      )
    );
  }

  Widget _setNeumorphicText(String text, TextBaseline textBaseline){
    return Container(
      alignment: Alignment.center,
      height: 75,
      width: 150,
      color: Colors.blue,
      child: NeumorphicText(
        text,
        style: const NeumorphicStyle(
          depth: 10,  //customize depth here
          intensity: 20,
          color: Colors.white, //customize color here
        ),
        textStyle: NeumorphicTextStyle(
          fontSize: 20, //customize size here
          fontWeight: FontWeight.bold,
          //textBaseline: textBaseline,
          // AND others usual text style properties (fontFamily, fontWeight, ...)
        ),
      ),
    );
  }

  Widget _setNeumorphicIcon(IconData icon, double size){
    return Container(
      alignment: Alignment.center,
      height: 75,
      width: 75,
      color: Colors.blue,
      child: NeumorphicIcon(
        icon,
        size: size,
      ),
    );
  }

  Widget _setNeumorphicRadio(int index){
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 50,
      color: Colors.blue,
      child: NeumorphicRadio(
        groupValue: index,
        style: NeumorphicRadioStyle(
          selectedColor: Colors.black87,
          selectedDepth: 10,
          unselectedColor: Colors.blue,
          unselectedDepth: 5,
          border: const NeumorphicBorder(width: 1, color: Colors.black87, isEnabled: true),
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(5.0)),
          shape: NeumorphicShape.convex,
          lightSource: const LightSource(1.0, 1.0),
        ),
        child: Container(
          alignment: Alignment.center,
          child: _functionUtil.initText2('${index + 1}', Colors.white, Colors.transparent, 20),
        )
      )
    );
  }

  Widget _setNeumorphicCheckBox(){
    return NeumorphicCheckbox(
      value: _isCheckBox,
      style: NeumorphicCheckboxStyle(
        selectedColor: Colors.blue,
        selectedDepth: 10,
        disabledColor: Colors.black87,
        unselectedDepth: 5,
        //border: const NeumorphicBorder(width: 1, color: Colors.black87, isEnabled: true),
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(5.0)),
        lightSource: const LightSource(1.0, 1.0),
      ),
      onChanged: (dynamic){
        setState(() {
          _isCheckBox = dynamic;
        });
      },
    );
  }

  Widget _setNeumorphicSwitch(){
    return NeumorphicSwitch(
      value: _isSwitch,
      onChanged: (bool) {
        setState(() {
          _isSwitch = bool;
        });
      },
    );
  }

  Widget _setNeumorphicSlider() {
    return _functionUtil.initPadding(
      8.0, 0.0, 8.0, 0.0,
      NeumorphicSlider(
        sliderHeight: 1.0,
        value: _sliderValue,
        style: SliderStyle(
          depth: 5,
          lightSource: const LightSource(1.0, 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        min: 0,
        max: 100,
        onChanged: (double) {
          setState(() {
            _sliderValue = double;
          });
        },
        onChangeStart: (double) {},
        onChangeEnd: (double) {},
      ),
    );
  }

  Widget _setNeumorphicProgress() {
    return _functionUtil.initPadding(
      8.0, 0.0, 8.0, 0.0,
      NeumorphicProgress(
        percent: _progressPercent,
        duration: const Duration(seconds: 2),
        style: const ProgressStyle(
          depth: 5,
          border: NeumorphicBorder(width: 1, color: Colors.black87, isEnabled: true),
          lightSource: LightSource(1.0, 1.0),
        ),
      ),
    );
  }

  Widget _setNeumorphicBackground() {
    return _functionUtil.initPadding(
      8.0, 0.0, 8.0, 0.0,
      NeumorphicBackground(
        padding: _functionUtil.initEdgeInsets(8.0, 8.0, 8.0, 8.0),
        backendColor: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
        child: Center(
          child: _functionUtil.initText2('Background', Colors.white, Colors.transparent, 20.0),
        ),
      ),
    );
  }

  Widget _setNeumorphicToggle(){
    return NeumorphicToggle(
      children: [
        ToggleElement(
          background: _indexToggle != 1 ? _functionUtil.initText2('index 1', Colors.white, Colors.transparent, 18) : _functionUtil.initText(''),
          //foreground: _indexToggle == 1 ? _functionUtil.initText2('index 1', Colors.white, Colors.transparent, 18) : _functionUtil.initText(''),
        ),
        ToggleElement(
          background: _indexToggle != 2 ?_functionUtil.initText2('index 2', Colors.white, Colors.transparent, 18) : _functionUtil.initText(''),
          //foreground: _indexToggle == 2 ?_functionUtil.initText2('index 2', Colors.white, Colors.transparent, 18) : _functionUtil.initText(''),
        ),
        ToggleElement(
          background: _indexToggle != 3 ?_functionUtil.initText2('index 3', Colors.white, Colors.transparent, 18) : _functionUtil.initText(''),
          //foreground: _indexToggle == 3 ?_functionUtil.initText2('index 3', Colors.white, Colors.transparent, 18) : _functionUtil.initText(''),
        ),
      ],
      thumb: ElevatedButton(
        child: _functionUtil.initText2('index $_indexToggle', Colors.white, Colors.transparent, 18),
        onPressed: (){

        },
      ),
      style: NeumorphicToggleStyle(
        depth: 5,
        backgroundColor: Colors.blue,
        lightSource: const LightSource(1.0, 1.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      onChanged: (int) {
        setState(() {
          _indexToggle = int + 1;
        });
      },
    );
  }

  _setProgress(){
    _timer = Timer(const Duration(seconds: 2), () {
      for(int i = 0; i < 101; i++){
        setState(() {
          _progressPercent = i.toDouble();
        });
      }
    });
  }

}

class SlidablePlayer extends StatefulWidget {
  const SlidablePlayer({Key? key, required this.animation, required this.child,}) : super(key: key);

  final Animation<double>? animation;
  final Widget child;

  @override
  _SlidablePlayerState createState() => _SlidablePlayerState();

  static _SlidablePlayerState? of(BuildContext context) {
    return context.findAncestorStateOfType<_SlidablePlayerState>();
  }
}

class _SlidablePlayerState extends State<SlidablePlayer> {
  final Set<SlidableController?> controllers = <SlidableController?>{};

  @override
  void initState() {
    super.initState();
    widget.animation!.addListener(handleAnimationChanged);
  }

  @override
  void dispose() {
    widget.animation!.removeListener(handleAnimationChanged);
    super.dispose();
  }

  void handleAnimationChanged() {
    final value = widget.animation!.value;
    for (var controller in controllers) {
      controller!.ratio = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class SlidableControllerSender extends StatefulWidget {
  const SlidableControllerSender({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  _SlidableControllerSenderState createState() => _SlidableControllerSenderState();
}

class _SlidableControllerSenderState extends State<SlidableControllerSender> {
  SlidableController? controller;
  _SlidablePlayerState? playerState;

  @override
  void initState() {
    super.initState();
    controller = Slidable.of(context);
    playerState = SlidablePlayer.of(context);
    playerState!.controllers.add(controller);
  }

  @override
  void dispose() {
    playerState!.controllers.remove(controller);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }
}

class MySlidable extends StatelessWidget {
  const MySlidable({Key? key, required this.motion,}) : super(key: key);

  final Widget motion;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Slidable(
        startActionPane: ActionPane(
          motion: motion,
          children: actions,
        ),
        child: SlidableControllerSender(
          child: ListViewTile1(text: motion.runtimeType.toString(), color: Colors.blue,),
        ),
      ),
    );
  }
}

class SlideAction extends StatelessWidget {
  const SlideAction({
    Key? key,
    required this.color,
    required this.icon,
    required this.label,
    this.flex = 1,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final int flex;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      flex: flex,
      backgroundColor: color,
      foregroundColor: Colors.white,
      onPressed: (_) {},
      icon: icon,
      label: label,
    );
  }
}