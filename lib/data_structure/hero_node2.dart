// @dart = 2.9

import 'package:flutter/material.dart';

class HeroNode2 {
  //構造函數
  int no;
  String name;
  String nickname;
  HeroNode2 next; //指向下一個節點, 默認為null
  HeroNode2 prev; //指向前一個節點, 默認為null

  //構造函數
  HeroNode2({@required this.no, @required this.name, @required this.nickname});

  //重寫toString
  @override
  String toString() {
    return "HeroNode[no=${no}name=${name}nickname=$nickname]\n";
  }

}