// @dart = 2.9

class UserDB {
  UserDB();

  int _id;
  String _name;
  String _desc;

  int get id => _id;

  String get name => _name;

  String get desc => _desc;

  set desc(String value) {
    _desc = value;
  }

  set name(String value) {
    _name = value;
  }

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['desc'] = _desc;
    return map;
  }

  UserDB.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    _desc = map['desc'];
  }
}