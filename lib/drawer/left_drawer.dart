import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:flutter_practice2/view/second_page.dart' as second;
import 'package:flutter_practice2/view/three_page.dart' as three;
import 'package:flutter_practice2/view/four_page.dart' as four;
import 'package:flutter_practice2/view/five_page.dart' as five;
import 'package:flutter_practice2/view/six_page.dart' as six;
import 'package:flutter_practice2/view/seven_page.dart' as seven;
import 'package:flutter_practice2/view/eight_page.dart' as eight;
import 'package:flutter_practice2/view/nine_page.dart' as nine;
import 'package:flutter_practice2/view/ten_page.dart' as ten;
import 'package:flutter_practice2/view/eleven_page.dart' as eleven;
import 'package:flutter_practice2/view/twelve_page.dart' as twelve;
import 'package:flutter_practice2/view/thirteen_page.dart' as thirteen;
import 'package:flutter_practice2/view/fourteen_page.dart' as fourteen;
import 'package:flutter_practice2/view/fifteen_page.dart' as fifteen;
import 'package:flutter_practice2/view/sixteen_page.dart' as sixteen;
import 'package:flutter_practice2/view/seventeen_page.dart' as seventeen;
import 'package:flutter_practice2/view/eighteen_page.dart' as eighteen;
import 'package:flutter_practice2/view/nineteen_page.dart' as nineteen;
import 'package:flutter_practice2/view/twenty_page.dart' as twenty;
import 'package:flutter_practice2/view/twentyone_page.dart' as twentyone;
import 'package:flutter_practice2/view/twentytwo_page.dart' as twentytwo;
import 'package:flutter_practice2/view/twentythree_page.dart' as twentythree;
import 'package:flutter_practice2/view/twentyfour_page.dart' as twentyfour;
import 'package:flutter_practice2/view/twentyfive_page.dart' as twentyfive;
import 'package:flutter_practice2/view/twentysix_page.dart' as twentysix;
import 'package:flutter_practice2/view/twentyseven_page.dart' as twentyseven;
import 'package:flutter_practice2/view/twentyeight_page.dart' as twentyeight;
import 'package:flutter_practice2/view/twentynine_page.dart' as twentynine;
import 'package:flutter_practice2/view/thirty_page.dart' as thirty;
import 'package:flutter_practice2/view/thirtyone_page.dart' as thirtyone;
import 'package:flutter_practice2/view/thirtytwo_page.dart' as thirtytwo;
import 'package:flutter_practice2/view/thirtythree_page.dart' as thirtythree;
import 'package:flutter_practice2/view/thirtyfour_page.dart' as thirtyfour;
import 'package:flutter_practice2/view/thirtyfive_page.dart' as thirtyfive;
import 'package:flutter_practice2/view/thirtysix_page.dart' as thirtysix;

class LeftDrawer extends StatefulWidget {
  const LeftDrawer({Key? key}) : super(key: key);

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    super.initState();
    _functionUtil = FunctionUtil();
  }

  @override
  Widget build(BuildContext context) {
    double statusBar = ScreenUtil.getInstance().statusBarHeight;
    double width = ScreenUtil.getInstance().screenWidth;
    double height = ScreenUtil.getInstance().screenHeight;
    LogUtil.e("LeftDrawer statusBar: $statusBar, width: $width, height: $height");

    return Container(
      color: Colors.white,
      width: ScreenUtil.getInstance().getWidth(240),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: Colors.teal,
            padding:
            EdgeInsets.only(top: ScreenUtil.getInstance().statusBarHeight),
            height: 160,
            child: const Center(
              child: Text(
                "Slash2270",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          _setDrawerItem(context, '2', _functionUtil.setScale(const second.SecondPage())),
          _setDrawerItem(context, '3', _functionUtil.setFade(const three.ThreePage())),
          _setDrawerItem(context, '4', _functionUtil.setSize(const four.FourPage())),
          _setDrawerItem(context, '5', _functionUtil.setRotate(const five.FivePage())),
          _setDrawerItem(context, '6', _functionUtil.setScale(const six.SixPage())),
          _setDrawerItem(context, '7', _functionUtil.setFade(const seven.SevenPage())),
          _setDrawerItem(context, '8', _functionUtil.setSize(const eight.EightPage())),
          _setDrawerItem(context, '9', _functionUtil.setRotate(const nine.NinePage())),
          _setDrawerItem(context, '10', _functionUtil.setScale(const ten.TenPage())),
          _setDrawerItem(context, '11', _functionUtil.setFade(const eleven.ElevenPage())),
          _setDrawerItem(context, '12', _functionUtil.setSize(const twelve.TwelvePage())),
          _setDrawerItem(context, '13', _functionUtil.setRotate(const thirteen.ThirteenPage())),
          _setDrawerItem(context, '14', _functionUtil.setScale(const fourteen.FourteenPage())),
          _setDrawerItem(context, '15', _functionUtil.setFade(const fifteen.FifteenPage())),
          _setDrawerItem(context, '16', _functionUtil.setSize(const sixteen.SixteenPage())),
          _setDrawerItem(context, '17', _functionUtil.setRotate(const seventeen.SeventeenPage())),
          _setDrawerItem(context, '18', _functionUtil.setScale(const eighteen.EighteenPage())),
          _setDrawerItem(context, '19', _functionUtil.setFade(const nineteen.NineteenPage())),
          _setDrawerItem(context, '20', _functionUtil.setSize(const twenty.TwentyPage())),
          _setDrawerItem(context, '21', _functionUtil.setSize(const twentyone.TwentyOnePage())),
          _setDrawerItem(context, '22', _functionUtil.setSize(const twentytwo.TwentyTwoPage())),
          _setDrawerItem(context, '23', _functionUtil.setSize(const twentythree.TwentyThreePage())),
          _setDrawerItem(context, '24', _functionUtil.setSize(const twentyfour.TwentyFourPage())),
          _setDrawerItem(context, '25', _functionUtil.setSize(const twentyfive.TwentyFivePage())),
          _setDrawerItem(context, '26', _functionUtil.setSize(const twentysix.TwentySixPage())),
          _setDrawerItem(context, '27', _functionUtil.setSize(const twentyseven.TwentySevenPage())),
          _setDrawerItem(context, '28', _functionUtil.setSize(const twentyeight.TwentyEightPage())),
          _setDrawerItem(context, '29', _functionUtil.setSize(const twentynine.TwentyNinePage())),
          _setDrawerItem(context, '30', _functionUtil.setSize(const thirty.ThirtyPage())),
          _setDrawerItem(context, '31', _functionUtil.setSize(const thirtyone.ThirtyOnePage())),
          _setDrawerItem(context, '32', _functionUtil.setSize(const thirtytwo.ThirtyTwoPage())),
          _setDrawerItem(context, '33', _functionUtil.setSize(const thirtythree.ThirtyThreePage())),
          _setDrawerItem(context, '34', _functionUtil.setSize(const thirtyfour.ThirtyFourPage())),
          _setDrawerItem(context, '35', _functionUtil.setSize(const thirtyfive.ThirtyFivePage())),
          _setDrawerItem(context, '36', _functionUtil.setSize(const thirtysix.ThirtySixPage())),
        ],
      ),
    );
  }

  Widget _setDrawerItem(BuildContext context, String page, Widget Function(BuildContext context, Animation<double> animation, Animation secondaryAnimation) widget){
    return InkWell(
      child: Container(
        padding:
        EdgeInsets.only(top: ScreenUtil.getInstance().statusBarHeight),
        height: 50,
        child: Text(
          "\t\tDrawer$page",
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
      onTap: ()=> Navigator.push(context, PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500), //动画时间为500毫秒
        pageBuilder: widget
      ),)
    );
  }
}