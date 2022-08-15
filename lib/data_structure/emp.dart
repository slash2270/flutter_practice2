// @dart = 2.9

import 'package:flutter/material.dart';

class Emp {
  int id;
  String name;
  Emp next; // 默認為null

  Emp({
    @required this.id,
    @required this.name,
  });
}