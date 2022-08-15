import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/algorithm_util.dart';
import 'package:flutter_practice2/util/sort_util.dart';
import '../util/function_util.dart';

class SortDemo extends StatefulWidget {
  const SortDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SortDemoState();
}

class SortDemoState extends State<SortDemo> {

  late FunctionUtil _functionUtil;
  late SortUtil _sortUtil;
  late String _text;
  late List _arr;

  @override
  void initState() {
    _sortUtil = SortUtil();
    _arr = [3,44,38,5,47,15,36,26,27,2,46,4,19,50,11];
    _text = '請選擇';
    _functionUtil = FunctionUtil();
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
          mainAxisAlignment: _text.length > 300 ? MainAxisAlignment.center : MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                _functionUtil.initText2('Sorting Algorithm 排序演算法', Colors.black, Colors.transparent, 24),
                ExtendedText(
                  _text,
                  style: _text.length > 300 ? const TextStyle(fontSize: 10.7) : const TextStyle(fontSize: 18),
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
                        label: _functionUtil.initText('選擇排序')
                    ),
                    onTap: () => _selectSort()
                ),
                 GestureDetector(
                    child: Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                      label: _functionUtil.initText('氣泡排序'),
                    ),
                    onTap: () => _bubbleSort()
                ),
                GestureDetector(
                    child: Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                      label: _functionUtil.initText('插入排序'),
                    ),
                    onTap: () => _insertSort()
                ),
                GestureDetector(
                    child: Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                      label: _functionUtil.initText('希爾排序'),
                    ),
                    onTap: () => _shellSort()
                ),
                GestureDetector(
                    child: Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                      label: _functionUtil.initText('歸併排序'),
                    ),
                    onTap: () => _mergeSort()
                ),
                GestureDetector(
                    child: Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                      label: _functionUtil.initText('快速排序'),
                    ),
                    onTap: () => _quickSort()
                ),
                GestureDetector(
                    child: Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                      label: _functionUtil.initText('堆排序'),
                    ),
                    onTap: () => _heapSort()
                ),
                GestureDetector(
                    child: Chip(
                        avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                        label: _functionUtil.initText('計數排序')
                    ),
                    onTap: () => _countSort()
                ),
                GestureDetector(
                    child: Chip(
                        avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                        label: _functionUtil.initText('桶排序')
                    ),
                    onTap: () => _bucketSort()
                ),
                GestureDetector(
                    child: Chip(
                        avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                        label: _functionUtil.initText('基數排序')
                    ),
                    onTap: () => _radixSort()
                ),
                GestureDetector(
                    child: Chip(
                        avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                        label: _functionUtil.initText('搖晃排序')
                    ),
                    onTap: () => _shakerSort()
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

  _selectSort() => setState(() => _text = _sortUtil.selectSort(_arr));
  _bubbleSort() => setState(() => _text = _sortUtil.bubbleSort(_arr));
  _insertSort() => setState(() => _text = _sortUtil.insertionSort(_arr));
  _shellSort() => setState(() => _text = _sortUtil.shellSort(_arr));
  _mergeSort() => setState(() => _text = _sortUtil.mergeSort(_arr).toString());
  _quickSort() => setState(() => _text = _sortUtil.quickSort([3,44,38,5,47,15,36,26,27,2,46,4,19,50,11], 0 , _arr.length - 1).toString());
  _heapSort() => setState(() => _text = _sortUtil.heapSort(_arr).toString());
  _countSort() => setState(() => _text = _sortUtil.countSort(_arr).toString());
  _bucketSort() => setState(() => _text = _sortUtil.bucketSort(_arr).toString());
  _radixSort() => setState(() => _text = _sortUtil.radixSort(_arr).toString());
  _shakerSort() => setState(() => _text = _sortUtil.shakerSort(_arr).toString());
  _cancelSort() => setState(() => _text ='Sorting:\n${[3, 44, 38, 5, 47, 15, 36, 26, 27, 2, 46, 4, 19, 50, 11]}');

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