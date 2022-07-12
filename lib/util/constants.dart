import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/view/eight_page.dart';
import 'package:flutter_practice2/view/eleven_page.dart';
import 'package:flutter_practice2/view/five_page.dart';
import 'package:flutter_practice2/view/four_page.dart';
import 'package:flutter_practice2/view/main_page.dart';
import 'package:flutter_practice2/view/nine_page.dart';
import 'package:flutter_practice2/view/second_page.dart';
import 'package:flutter_practice2/view/seven_page.dart';
import 'package:flutter_practice2/view/six_page.dart';
import 'package:flutter_practice2/view/ten_page.dart';
import 'package:flutter_practice2/view/three_page.dart';
import 'package:flutter_practice2/view/twelve_page.dart';

class Constants{

  static const aApiKey = 'AIzaSyDzawQDDnl2psVF-v0L4w7Cn8wdH3x0hsA';
  static const bApiKey = 'AIzaSyBIJ9TJpFeNrUkWy4iyQV_0nJDXmXZHYc0';

  static const routeSearch = '/search';
  static const routeHome = '/home';
  static const routeSettings = '/settings';
  static const routePrefixDeviceSetup = '/setup/';
  static const routeDeviceSetupStartPage = 'find_devices';
  static const routeDeviceSetupStart = '/setup/$routeDeviceSetupStartPage';
  static const routeDeviceSetupSelectDevicePage = 'select_device';
  static const routeDeviceSetupConnectingPage = 'connecting';
  static const routeDeviceSetupFinishedPage = 'finished';

  static const colorRed = Colors.red;
  static const colorBlue = Colors.blue;
  static const colorCyan = Colors.cyan;
  static const colorBlack = Colors.black;
  static const colorGreen = Colors.green;
  static const colorYellow = Colors.yellow;
  static const colorOrange = Colors.orange;
  static const colorPurple = Colors.purple;
  static const colorRedAccent = Colors.redAccent;
  static const colorBlueAccent = Colors.blueAccent;
  static const colorTransparent = Colors.transparent;
  static const colorPurpleAccent = Colors.purpleAccent;
  static const colorLightGreenAccent = Colors.lightGreenAccent;

  static const Color darkBlue = Color.fromARGB(255, 18, 32, 47);
  static const defaultColor = Color(0xFF34568B);

  static List<Color> listColors = [Colors.blue.shade900, Colors.blue.shade800, Colors.blue.shade700, Colors.blue.shade600, Colors.blue.shade500, Colors.blue.shade400, Colors.blue.shade300, Colors.blue.shade200, Colors.blue.shade100,];

  static const List<Widget> listClass = [
    MainPage(), SecondPage(), ThreePage(), FourPage(), FivePage(), SixPage(), SevenPage(), EightPage(), NinePage(), TenPage(), ElevenPage(), TwelvePage()
  ];
  static const List<String> listRoute = [
    'First', 'Second', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten'
  ];
  static const List<String> listArguments = [
    'First', 'Second', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten'
  ];

}