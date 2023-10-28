class ProductGategori {
  int? id;
  String? name;
  ProductGategori({
    this.id,
    this.name,
  });

  ProductGategori.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
