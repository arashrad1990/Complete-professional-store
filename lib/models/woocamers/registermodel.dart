class CustomerModel {
  String? fristnName;
  String? lastName;
  String? email;
  String? pasword;

  CustomerModel({
    this.fristnName,
    this.lastName,
    this.email,
    this.pasword,
  });

  CustomerModel.fromJson(Map<String, dynamic> json) {
    fristnName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    pasword = json['password'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data.addAll({
      "first_name": fristnName,
      "last_name": lastName,
      "email": email,
      "password": pasword,
    });
    return data;
  }
}
