class LoginModel {
  bool? success;
  int? statusCode;
  String? code;
  String? message;
  Data? data;
  LoginModel({
    this.success,
    this.statusCode,
    this.code,
    this.message,
    this.data,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    code = json['code'];
    message = json['message'];
    if (data.toString().isNotEmpty) {
      data = Data.fromJson(json['data']);
    }
  }
  Map<String, dynamic> tojson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['code'] = success;
    data['message'] = message;
    if (this.data.toString().isNotEmpty) {
      data['data'] = this.data!.tojson();
    }
    return data;
  }
}

class Data {
  String? token;
  int? id;
  String? email;
  String? nicename;
  String? firstName;
  String? lastName;
  String? displayName;

  Data({
    this.token,
    this.id,
    this.email,
    this.nicename,
    this.firstName,
    this.lastName,
    this.displayName,
  });

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    email = json['email'];
    nicename = json['nicename'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    displayName = json['displayName'];
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['id'] = id;
    data['email'] = email;
    data['nicename'] = nicename;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['displayName'] = displayName;
    return data;
  }
}
