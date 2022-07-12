class RouteBean {
  String? id;

  RouteBean({this.id});

  /// must.
  RouteBean.fromJson(Map<String, dynamic> json) : id = json['id'];

  /// must.
  Map<String, dynamic> toJson() => {'id': id,};

  @override
  String toString() {
    StringBuffer sb = StringBuffer('{');
    sb.write("\"id\":\"$id\"");
    sb.write('}');
    return sb.toString();
  }
}