class TokenBean {
  String? access;
  String? id;
  String? userName;
  String? fullName;
  String? profilePicture;

  TokenBean({this.access, this.id, this.userName, this.fullName, this.profilePicture});

  TokenBean.fromJson(Map<String, dynamic> json) {
    access = json['access_token'];
    id = json['user']['id'];
    userName = json['user']['username'];
    fullName = json['user']['full_name'];
    profilePicture = json['user']['profile_picture'];
  }

}