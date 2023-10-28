class AddToCartRegModel {
  int? userId;
  List<CartProduct>? products;

  AddToCartRegModel({
    this.userId,
    this.products,
  });

  AddToCartRegModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    if (json['products'] != null) {
      json['products'].forEach((v) {
        products!.add(CartProduct.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartProduct {
  int? productId;
  int? quantity;

  CartProduct({
    this.productId,
    this.quantity,
  });

  CartProduct.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['quantity'] = quantity;
    return data;
  }
}
