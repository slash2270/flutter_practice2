import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/search_util.dart';
import '../util/function_util.dart';

class SearchDemo extends StatefulWidget {
  const SearchDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchDemoState();
}

class SearchDemoState extends State<SearchDemo> {

  late FunctionUtil _functionUtil;
  late SearchUtil _searchUtil;
  late String _text;

  @override
  void initState() {
    _text = '請選擇';
    _functionUtil = FunctionUtil();
    _searchUtil = SearchUtil();
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
                _functionUtil.initText2('SearchAlgorithm 搜尋演算法', Colors.black, Colors.transparent, 24),
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
              alignment: WrapAlignment.spaceAround, //沿主轴方向居中
              children: <Widget>[
                GestureDetector(
                    child: Chip(
                        avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                        label: _functionUtil.initText('還原')
                    ),
                    onTap: () => _cancelSort()
                ),
                GestureDetector(
                    child: Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                      label: _functionUtil.initText('線性搜尋 Linear Search'),
                    ),
                    onTap: () => _linearSearch()
                ),
                GestureDetector(
                    child: Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                      label: _functionUtil.initText('二元搜尋 Binary Search'),
                    ),
                    onTap: () => _binarySearch()
                ),
                GestureDetector(
                    child: Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                      label: _functionUtil.initText('插值搜尋 InterValue Search'),
                    ),
                    onTap: () => _interValueSearch()
                ),
                GestureDetector(
                    child: Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.blue, child: _functionUtil.initIcon(Icons.functions)),
                      label: _functionUtil.initText('費氏搜尋 Fibonacci Search'),
                    ),
                    onTap: () => _fibSearch()
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

  _linearSearch() => setState(() => _text = _searchUtil.linear());
  _binarySearch() => setState(() => _text = _searchUtil.binary());
  _interValueSearch() => setState(() => _text = _searchUtil.interpolation());
  _fibSearch() => setState(() => _text = _searchUtil.fibSearch());

  _cancelSort() {
    setState(() => _text = '請選擇');
  }
}

class AlgorithmTextBuilder extends SpecialTextSpanBuilder{

  @override
  SpecialText? createSpecialText(String flag, {TextStyle? textStyle, SpecialTextGestureTapCallback? onTap, required int index}) {

    if (flag.isEmpty || flag == "") return null;

    // if (isStart(flag, 'S')) {
    //   return AlgorithmSpecialText('S', ':', textStyle?.copyWith(color: Colors.blue, fontSize: 18.0));
    // } else if(isStart(flag, 'M')) {
    //   return AlgorithmSpecialText('M', ':', textStyle?.copyWith(color: Colors.blue, fontSize: 18.0));
    // } else if(isStart(flag, 'P')) {
    //   return AlgorithmSpecialText('P', ':', textStyle?.copyWith(color: Colors.blue, fontSize: 18.0));
    // } else if(isStart(flag, 'L')) {
    //   return AlgorithmSpecialText('L', ':', textStyle?.copyWith(color: Colors.blue, fontSize: 18.0));
    // } else if(isStart(flag, 'J')) {
    //   return AlgorithmSpecialText('J', ':', textStyle?.copyWith(color: Colors.blue, fontSize: 18.0));
    // }
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