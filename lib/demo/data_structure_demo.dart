import 'dart:collection';

import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/data_structure_util.dart';
import '../util/function_util.dart';

class DataStructureDemo extends StatefulWidget {
  const DataStructureDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DataStructureDemoState();
}

class DataStructureDemoState extends State<DataStructureDemo> {

  late FunctionUtil _functionUtil;
  late DataStructureUtil _dataStructureUtil;
  late String _text;
  late int queueLoop = 0;
  Queue queue = Queue();

  @override
  void initState() {
    _text = '請選擇';
    _functionUtil = FunctionUtil();
    _dataStructureUtil = DataStructureUtil();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                _functionUtil.initText2('DataStructure 資料結構', Colors.black, Colors.transparent, 24),
                ExtendedText(
                  _text,
                  style: _setStyle(),
                  textAlign: TextAlign.center,
                  specialTextSpanBuilder: AlgorithmTextBuilder(),
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
            Wrap(
              spacing: 15.0, // 主轴(水平)方向间距
              runSpacing: 5.0, // 纵轴（垂直）方向间距
              alignment: WrapAlignment.center, //沿主轴方向居中
              children: <Widget>[
                GestureDetector(
                    child: Chip(
                        avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                        label: _functionUtil.initText('稀疏矩陣 Sparse Matrix')
                    ),
                    onTap: () => _sparseMatrix()
                ),
                GestureDetector(
                    child: Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                      label: _functionUtil.initText('環形佇列 Queue'),
                    ),
                    onTap: () => _queue()
                ),
                GestureDetector(
                    child: Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                      label: _functionUtil.initText('單向鏈結串列 Single LinkedList'),
                    ),
                    onTap: () => _singleLinkedList()
                ),
                GestureDetector(
                    child: Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                      label: _functionUtil.initText('雙向鏈結串列 Double LinkedList'),
                    ),
                    onTap: () => _doubleLinkedList()
                ),
                GestureDetector(
                    child: Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                      label: _functionUtil.initText('約瑟夫問題 Josephus Problem'),
                    ),
                    onTap: () => _josephusProblem()
                ),
                GestureDetector(
                    child: Chip(
                        avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                        label: _functionUtil.initText('還原')
                    ),
                    onTap: () => _cancelSort()
                ),
              ],
            )
          ],
        )
    );
  }

  TextStyle _setStyle(){
    if(_text.length > 500){
      return const TextStyle(fontSize: 13);
    }else if(_text.length > 800){
      return const TextStyle(fontSize: 10);
    }else{
      return const TextStyle(fontSize: 18);
    }
  }

  _sparseMatrix() async{
    String getText = await _dataStructureUtil.sparseMatrix();
    setState(() {
      _text = getText;
    });
  }

  _queue(){
    if(queueLoop != 0) {
      if (queueLoop > 9) {
        _zeroQueue();
        setState(() => _text = queue.toString());
      } else if (queueLoop > 4) {
        queue.removeLast();
        _addQueue();
      } else {
        _addQueue();
      }
    }else{
      queue.addFirst(queueLoop);
      setState(() => _text = queue.toString());
      queueLoop++;
    }
  }

  _addQueue(){
    queue.addFirst(queueLoop);
    setState(() => _text = queue.toString());
    queueLoop++;
  }

  _zeroQueue(){
    queueLoop = 0;
    queue.clear();
  }

  _singleLinkedList() => setState(() => _text = _dataStructureUtil.singleLinkedList());
  _doubleLinkedList() => setState(() => _text = _dataStructureUtil.doubleLinkedList());
  _josephusProblem() => setState(() => _text = _dataStructureUtil.josephusProblem());

  _cancelSort() {
    _zeroQueue();
    setState(() => _text = '請選擇');
  }
}

class AlgorithmTextBuilder extends SpecialTextSpanBuilder{

  @override
  SpecialText? createSpecialText(String flag, {TextStyle? textStyle, SpecialTextGestureTapCallback? onTap, required int index}) {

    if (flag.isEmpty || flag == "") return null;

    if (isStart(flag, 'S')) {
      return AlgorithmSpecialText('S', ':', textStyle?.copyWith(color: Colors.blue, fontSize: 18.0));
    } else if(isStart(flag, 'M')) {
      return AlgorithmSpecialText('M', ':', textStyle?.copyWith(color: Colors.blue, fontSize: 18.0));
    } else if(isStart(flag, 'P')) {
      return AlgorithmSpecialText('P', ':', textStyle?.copyWith(color: Colors.blue, fontSize: 18.0));
    } else if(isStart(flag, 'L')) {
      return AlgorithmSpecialText('L', ':', textStyle?.copyWith(color: Colors.blue, fontSize: 18.0));
    } else if(isStart(flag, 'J')) {
      return AlgorithmSpecialText('J', ':', textStyle?.copyWith(color: Colors.blue, fontSize: 18.0));
    }
    return null;
  }

}

class AlgorithmSpecialText extends SpecialText{
  AlgorithmSpecialText(String startFlag, String endFlag, TextStyle? textStyle) : super(startFlag, endFlag, textStyle);

  @override
  InlineSpan finishText() {
    final String atText = toString();
    return TextSpan(
      text: atText,
      style: textStyle,
    );
  }

}