class ZarinpalVerify {
  Data? data;
  dynamic errors;

  ZarinpalVerify({
    this.data,
    this.errors,
  });
// NABEGHEHA.COM
  ZarinpalVerify.fromJson(Map<String, dynamic> json) {
    if (data != null) {
      data = Data.fromJson(json["data"]);
    }
    if (errors != null) {
      errors = Data.fromJson(json["errors"]);
    }
  }
}

class Data {
  Data({
    this.code,
    this.message,
    this.authority,
  });

  int? code;
  String? message;
  String? authority;
  int? refId;
// NABEGHEHA.COM
  Data.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    message = json["message"];
    authority = json["authority"];
    refId = json['ref_id'];
  }
}
