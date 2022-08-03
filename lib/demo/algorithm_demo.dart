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
  late GestureDetector _gestureDetector;
  late Chip _chip;
  late String _text;
  late List<int> _arr;

  @override
  void initState() {
    _calculate = Calculate();
    _arr = [3,44,38,5,47,15,36,26,27,2,46,4,19,50,11];
    _text = _arr.toString();
    _chip = Chip(label: Container());
    _gestureDetector = GestureDetector();
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  _functionUtil.initText2('Algorithm 演算法', Colors.black, Colors.transparent, 24),
                  _functionUtil.initText2(_text, Colors.black, Colors.transparent, 20),
                ],
              ),
              Wrap(
                spacing: 15.0, // 主轴(水平)方向间距
                runSpacing: 5.0, // 纵轴（垂直）方向间距
                alignment: WrapAlignment.center, //沿主轴方向居中
                children: <Widget>[
                  _gestureDetector = GestureDetector(
                      child: _chip = Chip(
                          avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                          label: _functionUtil.initText('選擇排序')
                      ),
                      onTap: () => _selectSort()
                  ),
                  _gestureDetector = GestureDetector(
                      child: _chip = Chip(
                        avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                        label: _functionUtil.initText('氣泡排序'),
                      ),
                      onTap: () => _bubbleSort()
                  ),
                  _gestureDetector = GestureDetector(
                      child: _chip = Chip(
                        avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                        label: _functionUtil.initText('插入排序'),
                      ),
                      onTap: () => _insertSort()
                  ),
                  _gestureDetector = GestureDetector(
                      child: _chip = Chip(
                        avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                        label: _functionUtil.initText('希爾排序'),
                      ),
                      onTap: () => _shellSort()
                  ),
                  _gestureDetector = GestureDetector(
                      child: _chip = Chip(
                        avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                        label: _functionUtil.initText('歸併排序'),
                      ),
                      onTap: () => _mergeSort()
                  ),
                  _gestureDetector = GestureDetector(
                      child: _chip = Chip(
                        avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                        label: _functionUtil.initText('快速排序'),
                      ),
                      onTap: () => _quickSort()
                  ),
                  _gestureDetector = GestureDetector(
                      child: _chip = Chip(
                        avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                        label: _functionUtil.initText('堆排序'),
                      ),
                      onTap: () => _heapSort()
                  ),
                  _gestureDetector = GestureDetector(
                      child: _chip = Chip(
                          avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                          label: _functionUtil.initText('計數排序')
                      ),
                      onTap: () => _countSort()
                  ),
                  _gestureDetector = GestureDetector(
                      child: _chip = Chip(
                          avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                          label: _functionUtil.initText('桶排序')
                      ),
                      onTap: () => _bucketSort()
                  ),
                  _gestureDetector = GestureDetector(
                      child: _chip = Chip(
                          avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                          label: _functionUtil.initText('基數排序')
                      ),
                      onTap: () => _radixSort()
                  ),
                  _gestureDetector = GestureDetector(
                      child: _chip = Chip(
                          avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                          label: _functionUtil.initText('搖晃排序')
                      ),
                      onTap: () => _shakerSort()
                  ),
                  _gestureDetector = GestureDetector(
                      child: _chip = Chip(
                          avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                          label: _functionUtil.initText('蒙地卡羅')
                      ),
                      onTap: () => _monteCarloRandom()
                  ),
                  _gestureDetector = GestureDetector(
                      child: _chip = Chip(
                          avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                          label: _functionUtil.initText('撲克牌洗牌')
                      ),
                      onTap: () => _shuffleRandom()
                  ),
                  _gestureDetector = GestureDetector(
                      child: _chip = Chip(
                          avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                          label: _functionUtil.initText('螃蟹擲骰')
                      ),
                      onTap: () => _crapsRandom()
                  ),
                  _gestureDetector = GestureDetector(
                      child: _chip = Chip(
                          avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                          label: _functionUtil.initText('恢復')
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
  _quickSort() => setState(() => _text = _calculate.quickSort(_arr, 0 , _arr.length - 1).toString());
  _heapSort() => setState(() => _text = _calculate.heapSort(_arr).toString());
  _countSort() => setState(() => _text = _calculate.countSort(_arr).toString());
  _bucketSort() => setState(() => _text = _calculate.bucketSort(_arr).toString());
  _radixSort() => setState(() => _text = _calculate.radixSort(_arr).toString());
  _shakerSort() => setState(() => _text = _calculate.shakerSort(_arr).toString());
  _monteCarloRandom() => setState(() => _text = _calculate.monteCarloRandom());
  _shuffleRandom() => setState(() => _text = _calculate.shuffleRandom().toString());
  _crapsRandom() => setState(() => _text = _calculate.crapsRandom());
  _cancelSort() => setState(() => _text = [3, 44, 38, 5, 47, 15, 36, 26, 27, 2, 46, 4, 19, 50, 11].toString());

}