// @dart = 2.9
//定義HeroNode, 每個HeroNode 對象就是一個節點
import 'package:flutter/material.dart';

class HeroNode {
  int no;
  String name;
  String nickname;
  HeroNode next; //指向下一個節點

  //構造函數
  HeroNode({@required this.no, @required this.name, @required this.nickname});

  //重寫toString
  @override
  String toString() {
    return "HeroNode[no=${no}name=${name}nickname=$nickname]\n";
  }

}