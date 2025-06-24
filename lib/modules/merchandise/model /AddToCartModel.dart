class AddToCart {
  bool? success;
  String? message;
  AddToCartData? data;

  AddToCart({this.success, this.message, this.data});

  AddToCart.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new AddToCartData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AddToCartData {
  String? userId;
  String? productId;
  int? quantity;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AddToCartData(
      {this.userId,
        this.productId,
        this.quantity,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  AddToCartData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    productId = json['productId'];
    quantity = json['quantity'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}