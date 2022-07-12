class CityBean {
  String? name;

  CityBean({this.name});

  /// must.
  CityBean.fromJson(Map<String, dynamic> json) : name = json['name'];

  /// must.
  Map<String, dynamic> toJson() => {
    'name': name,
  };

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"name\":\"$name\"");
    sb.write('}');
    return sb.toString();
  }
}