class ZarinpallModel {
  Data? data;
  List<dynamic>? errors;

  ZarinpallModel({
    this.data,
    this.errors,
  });
  ZarinpallModel.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
    errors = List<dynamic>.from(json['errors']).map((e) => e).toList();

  }
}

class Data {
  int? code;
  String? message;
  String? authority;
  String? feetype;
  int? fee;

  Data({
    this.code,
    this.message,
    this.authority,
    this.feetype,
    this.fee,
  });

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    authority = json['authority'];
    feetype = json['feetype'];
    fee = json['fee'];
  }
}
