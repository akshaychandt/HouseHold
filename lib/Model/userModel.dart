class UserModel {
  String? message;
  String? name;
  String? occupation;
  String? email;

  UserModel({this.message, this.name, this.occupation, this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    name = json['name'];
    occupation = json['occupation'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['name'] = this.name;
    data['occupation'] = this.occupation;
    data['email'] = this.email;
    return data;
  }
}
