class MyOrderDetailResponseModel {
  bool? success;
  String? message;
  MyOrderDetailData? data;

  MyOrderDetailResponseModel({this.success, this.message, this.data});

  MyOrderDetailResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new MyOrderDetailData.fromJson(json['data']) : null;
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

class MyOrderDetailData {
  String? orderId;
  Address? address;
  String? orderDate;
  String? updatedAt;
  String? status;
  String? paymentStatus;
  String? orderStatus;
  num? totalAmount;
  String? cancellationReason;
  Venue? venue;
  User? user;
  List<Items>? items;

  MyOrderDetailData(
      {this.orderId,
        this.address,
        this.orderDate,
        this.updatedAt,
        this.status,
        this.paymentStatus,
        this.orderStatus,
        this.totalAmount,
        this.cancellationReason,
        this.venue,
        this.user,
        this.items});

  MyOrderDetailData.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    orderDate = json['orderDate'];
    updatedAt = json['updatedAt'];
    status = json['status'];
    paymentStatus = json['paymentStatus'];
    orderStatus = json['orderStatus'];
    totalAmount = json['totalAmount'];
    cancellationReason = json['cancellationReason'];
    venue = json['venue'] != null ? new Venue.fromJson(json['venue']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['orderDate'] = this.orderDate;
    data['updatedAt'] = this.updatedAt;
    data['status'] = this.status;
    data['paymentStatus'] = this.paymentStatus;
    data['orderStatus'] = this.orderStatus;
    data['totalAmount'] = this.totalAmount;
    data['cancellationReason'] = this.cancellationReason;
    if (this.venue != null) {
      data['venue'] = this.venue!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  String? nameOfRecipient;
  String? phoneNumber;
  String? street;
  String? city;
  String? state;
  String? pinCode;

  Address(
      {this.nameOfRecipient,
        this.phoneNumber,
        this.street,
        this.city,
        this.state,
        this.pinCode});

  Address.fromJson(Map<String, dynamic> json) {
    nameOfRecipient = json['nameOfRecipient'];
    phoneNumber = json['phoneNumber'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    pinCode = json['pinCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameOfRecipient'] = this.nameOfRecipient;
    data['phoneNumber'] = this.phoneNumber;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pinCode'] = this.pinCode;
    return data;
  }
}

class Venue {
  String? id;
  String? name;
  String? address;

  Venue({this.id, this.name, this.address});

  Venue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;

  User({this.id, this.name, this.email, this.phoneNumber});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}

class Items {
  String? id;
  String? productId;
  String? name;
  String? image;
  String? description;
  // List<Null>? tags;
  num? price;
  num? quantity;
  num? total;

  Items(
      {this.id,
        this.productId,
        this.name,
        this.image,
        this.description,
        // this.tags,
        this.price,
        this.quantity,
        this.total});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    // if (json['tags'] != null) {
    //   tags = <Null>[];
    //   json['tags'].forEach((v) {
    //     tags!.add(new Null.fromJson(v));
    //   });
    // }
    price = json['price'];
    quantity = json['quantity'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    // if (this.tags != null) {
    //   data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    // }
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    return data;
  }
}