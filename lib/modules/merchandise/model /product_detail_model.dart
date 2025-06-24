class ProductDetailModel {
  bool? success;
  String? message;
  ProductDetailData? data;

  ProductDetailModel({this.success, this.message, this.data});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new ProductDetailData.fromJson(json['data']) : null;
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

class ProductDetailData {
  String? sId;
  String? productName;
  String? description;
  String? specification;
  String? primaryImage;
  List<String>? thumbnails;
  int? actualPrice;
  int? discountedPrice;
  List<VenueAndQuantity>? venueAndQuantity;
  // List<S>? reviews;
  // Null? category;
  // Null? subCategory;
  // List<Null>? tags;
  bool? isActive;
  num? averageRating;
  num? totalReviews;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ProductDetailData(
      {this.sId,
        this.productName,
        this.description,
        this.specification,
        this.primaryImage,
        this.thumbnails,
        this.actualPrice,
        this.discountedPrice,
        this.venueAndQuantity,

        this.isActive,
        this.averageRating,
        this.totalReviews,
        this.createdAt,
        this.updatedAt,
        this.iV});

  ProductDetailData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    description = json['description'];
    specification = json['specification'];
    primaryImage = json['primaryImage'];
    thumbnails = json['thumbnails'].cast<String>();
    actualPrice = json['actualPrice'];
    discountedPrice = json['discountedPrice'];
    if (json['venueAndQuantity'] != null) {
      venueAndQuantity = <VenueAndQuantity>[];
      json['venueAndQuantity'].forEach((v) {
        venueAndQuantity!.add(new VenueAndQuantity.fromJson(v));
      });
    }

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
    data['thumbnails'] = this.thumbnails;
    data['actualPrice'] = this.actualPrice;
    data['discountedPrice'] = this.discountedPrice;

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
  int? quantity;
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