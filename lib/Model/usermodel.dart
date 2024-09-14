class UserModel {
  int? id;
  String? username;
  String? email;
  int? mobileNo;
  String? password;

  UserModel({this.id, this.username, this.email, this.mobileNo, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['password'] = this.password;
    return data;
  }
}
