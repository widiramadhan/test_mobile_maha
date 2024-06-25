class UsersReq {
  String? firstName;
  String? lastName;
  String? email;
  String? avatar;

  UsersReq({this.firstName, this.lastName, this.email, this.avatar});

  UsersReq.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    return data;
  }
}