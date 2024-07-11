class UserModel {
  UserModel({
    this.email,
    this.password,
    this.username,
    this.avatar,
    this.name,
  });
  String? email, username, password, avatar, name;

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    avatar = json['avatar'];
    name = json['name'];
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
