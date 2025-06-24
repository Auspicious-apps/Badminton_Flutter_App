class AddToCartList {
  bool? success;
  String? message;
  List<CartListData>? data;

  AddToCartList({this.success, this.message, this.data});

  AddToCartList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CartListData>[];
      json['data'].forEach((v) {
        data!.add(new CartListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartListData {
  String? sId;
  String? userId;
  ProductId? productId;
  num? quantity;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CartListData(
      {this.sId,
        this.userId,
        this.productId,
        this.quantity,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CartListData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    productId = json['productId'] != null
        ? new ProductId.fromJson(json['productId'])
        : null;
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    if (this.productId != null) {
      data['productId'] = this.productId!.toJson();
    }
    data['quantity'] = this.quantity;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ProductId {
  String? sId;
  String? productName;
  String? description;
  String? specification;
  String? primaryImage;

  num? actualPrice;
  num? discountedPrice;
  List<VenueAndQuantity>? venueAndQuantity;

  bool? isActive;
  num? averageRating;
  num? totalReviews;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ProductId(
      {this.sId,
        this.productName,
        this.description,
        this.specification,
        this.primaryImage,

        this.actualPrice,
        this.discountedPrice,
        this.venueAndQuantity,

        this.isActive,
        this.averageRating,
        this.totalReviews,
        this.createdAt,
        this.updatedAt,
        this.iV});

  ProductId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    description = json['description'];
    specification = json['specification'];
    primaryImage = json['primaryImage'];
    // if (json['thumbnails'] != null) {
    //   thumbnails = <Null>[];
    //   json['thumbnails'].forEach((v) {
    //     thumbnails!.add(new Null.fromJson(v));
    //   });
    // }
    actualPrice = json['actualPrice'];
    discountedPrice = json['discountedPrice'];
    if (json['venueAndQuantity'] != null) {
      venueAndQuantity = <VenueAndQuantity>[];
      json['venueAndQuantity'].forEach((v) {
        venueAndQuantity!.add(new VenueAndQuantity.fromJson(v));
      });
    }
    // if (json['reviews'] != null) {
    //   reviews = <Null>[];
    //   json['reviews'].forEach((v) {
    //     reviews!.add(new Null.fromJson(v));
    //   });
    // }

    // if (json['tags'] != null) {
    //   tags = <Null>[];
    //   json['tags'].forEach((v) {
    //     tags!.add(new Null.fromJson(v));
    //   });
    // }
    isActive = json['isActive'];
    averageRating = json['averageRating'];
    totalReviews = json['totalReviews'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productName'] = this.productName;
    data['description'] = this.description;
    data['specification'] = this.specification;
    data['primaryImage'] = this.primaryImage;
    // if (this.thumbnails != null) {
    //   data['thumbnails'] = this.thumbnails!.map((v) => v.toJson()).toList();
    // }
    data['actualPrice'] = this.actualPrice;
    data['discountedPrice'] = this.discountedPrice;
    if (this.venueAndQuantity != null) {
      data['venueAndQuantity'] =
          this.venueAndQuantity!.map((v) => v.toJson()).toList();
    }
    // if (this.reviews != null) {
    //   data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    // }

    // if (this.tags != null) {
    //   data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    // }
    data['isActive'] = this.isActive;
    data['averageRating'] = this.averageRating;
    data['totalReviews'] = this.totalReviews;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class VenueAndQuantity {
  String? venueId;
  num? quantity;
  String? sId;

  VenueAndQuantity({this.venueId, this.quantity, this.sId});

  VenueAndQuantity.fromJson(Map<String, dynamic> json) {
    venueId = json['venueId'];
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['venueId'] = this.venueId;
    data['quantity'] = this.quantity;
    data['_id'] = this.sId;
    return data;
  }
}

