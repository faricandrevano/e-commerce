class UserAllModel {
  UserAllModel(
      {this.city,
      this.email,
      this.firstname,
      this.lastname,
      this.password,
      this.phone,
      this.street,
      this.username});
  String? email, username, password, firstname, lastname, city, street, phone;

  UserAllModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    city = json['city'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    street = json['street'];
    username = json['username'];
    password = json['password'];
  }
}
