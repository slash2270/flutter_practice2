import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/calculate_util.dart';
import '../util/function_util.dart';

class AlgorithmDemo extends StatefulWidget {
  const AlgorithmDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AlgorithmDemoState();
}

class AlgorithmDemoState extends State<AlgorithmDemo> {

  late FunctionUtil _functionUtil;
  late Calculate _calculate;
  late String _text;
  late List _arr;

  @override
  void initState() {
    _calculate = Calculate();
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
                _functionUtil.initText2('Algorithm 演算法', Colors.black, Colors.transparent, 24),
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
                        label: _functionUtil.initText('蒙地卡羅')
                    ),
                    onTap: () => _monteCarloRandom()
                ),
                GestureDetector(
                    child: Chip(
                        avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                        label: _functionUtil.initText('舍伍德')
                    ),
                    onTap: () => _shuffleRandom()
                ),
                GestureDetector(
                    child: Chip(
                        avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                        label: _functionUtil.initText('螃蟹擲骰')
                    ),
                    onTap: () => _crapsRandom()
                ),
                GestureDetector(
                    child: Chip(
                        avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                        label: _functionUtil.initText('拉斯維加斯')
                    ),
                    onTap: () => _lasVegasRandom()
                ),
                GestureDetector(
                    child: Chip(
                        avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                        label: _functionUtil.initText('約瑟夫環')
                    ),
                    onTap: () => _josephusRandom()
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

  _selectSort() => setState(() => _text = _calculate.selectSort(_arr));
  _bubbleSort() => setState(() => _text = _calculate.bubbleSort(_arr));
  _insertSort() => setState(() => _text = _calculate.insertionSort(_arr));
  _shellSort() => setState(() => _text = _calculate.shellSort(_arr));
  _mergeSort() => setState(() => _text = _calculate.mergeSort(_arr).toString());
  _quickSort() => setState(() => _text = _calculate.quickSort([3,44,38,5,47,15,36,26,27,2,46,4,19,50,11], 0 , _arr.length - 1).toString());
  _heapSort() => setState(() => _text = _calculate.heapSort(_arr).toString());
  _countSort() => setState(() => _text = _calculate.countSort(_arr).toString());
  _bucketSort() => setState(() => _text = _calculate.bucketSort(_arr).toString());
  _radixSort() => setState(() => _text = _calculate.radixSort(_arr).toString());
  _shakerSort() => setState(() => _text = _calculate.shakerSort(_arr).toString());
  _monteCarloRandom() => setState(() => _text = _calculate.monteCarloRandom());
  _shuffleRandom() => setState(() => _text = _calculate.sherwoodRandom().toString());
  _crapsRandom() => setState(() => _text = _calculate.crapsRandom());
  _lasVegasRandom() => setState(() => _text = _calculate.lasVegasRandom());
  _josephusRandom() => setState(() => _text = _calculate.josephusRandom());
  _cancelSort() => setState(() => _text =
      'Sorting:\n${[3, 44, 38, 5, 47, 15, 36, 26, 27, 2, 46, 4, 19, 50, 11]}\n'
      'MonteCarlo:\n隨機判斷點是否在四分之一圓內\n'
      'Sherwood:\n建構52張撲克牌 並有隨機洗牌功能\n'
      'LasVegas:\n8皇后 在n×n格的棋盤上放置彼此不受攻擊的n個皇后\n'
      'Josephus:\n41個人圍圓 找出約瑟夫和同伴的位置\n');
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