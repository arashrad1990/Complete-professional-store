class ProductModel {
  int? id;
  String? name;
  String? description;
  String? shortdescription;
  String? price;
  String? regularprice;
  List<Categories>? categories;
  List<WooImages>? images;
  bool? isFavorit = false;
  ProductModel({
    this.id,
    this.name,
    this.description,
    this.shortdescription,
    this.price,
    this.regularprice,
    this.categories,
    this.images,
    this.isFavorit,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    shortdescription = json['short_description'];
    regularprice = json['regular_price'];

    if (json['images'] != null) {
      images = <WooImages>[];
      json['images'].forEach((v) {
        images?.add(WooImages.fromJson(v));
      });
    }

    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
  }
}

class WooImages {
  String? src;
  WooImages({
    this.src,
  });

  WooImages.fromJson(Map<String, dynamic> json) {
    src = json['src'];
  }
}

class Categories {
  int? id;
  String? name;
  Categories({
    this.name,
    this.id,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }
  @override
  String toString() {
    return removeAllHtmlTags(name.toString());
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}
