class AllMerchadiseModel {
  bool? success;
  String? message;
  List<MerChandiseData>? data;

  AllMerchadiseModel({this.success, this.message, this.data});

  AllMerchadiseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MerChandiseData>[];
      json['data'].forEach((v) {
        data!.add(new MerChandiseData.fromJson(v));
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

class MerChandiseData {
  String? sId;
  String? productName;
  String? description;
  String? specification;
  String? primaryImage;
  List<String>? thumbnails;
  num? actualPrice;
  num? discountedPrice;
  List<VenueAndQuantity>? venueAndQuantity;
  // List<Null>? reviews;
  // Null? category;
  // Null? subCategory;
  List<String>? tags;
  bool? isActive;
  num? averageRating;
  num? totalReviews;
  String? createdAt;
  String? updatedAt;
  int? iV;

  MerChandiseData(
      {this.sId,
        this.productName,
        this.description,
        this.specification,
        this.primaryImage,
        this.thumbnails,
        this.actualPrice,
        this.discountedPrice,
        this.venueAndQuantity,
        // this.reviews,
        // this.category,
        // this.subCategory,
        this.tags,
        this.isActive,
        this.averageRating,
        this.totalReviews,
        this.createdAt,
        this.updatedAt,
        this.iV});

  MerChandiseData.fromJson(Map<String, dynamic> json) {
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
    // if (json['reviews'] != null) {
    //   reviews = <Null>[];
    //   json['reviews'].forEach((v) {
    //     reviews!.add(new Null.fromJson(v));
    //   });
    // }
    // category = json['category'];
    // subCategory = json['subCategory'];
    tags = json['tags'].cast<String>();
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
    if (this.venueAndQuantity != null) {
      data['venueAndQuantity'] =
          this.venueAndQuantity!.map((v) => v.toJson()).toList();
    }
    // if (this.reviews != null) {
    //   data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    // }
    // data['category'] = this.category;
    // data['subCategory'] = this.subCategory;
    data['tags'] = this.tags;
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