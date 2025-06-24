class My_Orders_Response {
  bool? success;
  String? message;
  List<MyOrderData>? data;


  My_Orders_Response({this.success, this.message, this.data});

  My_Orders_Response.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MyOrderData>[];
      json['data'].forEach((v) {
        data!.add(new MyOrderData.fromJson(v));
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

class MyOrderData {
  String? orderId;
  Address? address;
  String? orderDate;
  String? status;
  String? paymentStatus;
  int? totalAmount;
  Venue? venue;
  List<Items>? items;

  MyOrderData(
      {this.orderId,
        this.address,
        this.orderDate,
        this.status,
        this.paymentStatus,
        this.totalAmount,
        this.venue,
        this.items});

  MyOrderData.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    orderDate = json['orderDate'];
    status = json['status'];
    paymentStatus = json['paymentStatus'];
    totalAmount = json['totalAmount'];
    venue = json['venue'] != null ? new Venue.fromJson(json['venue']) : null;
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
    data['status'] = this.status;
    data['paymentStatus'] = this.paymentStatus;
    data['totalAmount'] = this.totalAmount;
    if (this.venue != null) {
      data['venue'] = this.venue!.toJson();
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

class Items {
  String? productId;
  String? name;
  String? image;
  int? price;
  int? quantity;
  int? total;

  Items(
      {this.productId,
        this.name,
        this.image,
        this.price,
        this.quantity,
        this.total});

  Items.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    quantity = json['quantity'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    return data;
  }
}

class Meta {
  int? total;
  int? page;
  int? limit;
  int? totalPages;
  bool? hasNextPage;
  bool? hasPreviousPage;

  Meta(
      {this.total,
        this.page,
        this.limit,
        this.totalPages,
        this.hasNextPage,
        this.hasPreviousPage});

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    hasNextPage = json['hasNextPage'];
    hasPreviousPage = json['hasPreviousPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['totalPages'] = this.totalPages;
    data['hasNextPage'] = this.hasNextPage;
    data['hasPreviousPage'] = this.hasPreviousPage;
    return data;
  }
}