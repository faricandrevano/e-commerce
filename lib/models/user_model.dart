class UserModel {
  UserModel({
    this.id,
    this.email,
    this.password,
    this.username,
    this.avatar,
    this.name,
  });
  String? email, username, password, avatar, name;
  int? id;
  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    avatar = json['avatar'];
    name = json['name'];
    id = json['id'];
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'password': password,
      'avatar': avatar
    };
  }
}

class Authorized {
  // ignore: non_constant_identifier_names
  Authorized({this.access_token, this.refresh_token});
  // ignore: non_constant_identifier_names
  String? access_token, refresh_token;
  Authorized.fromJson(Map<String, dynamic> json) {
    access_token = json['access_token'];
    access_token = json['access_token'];
  }
}
