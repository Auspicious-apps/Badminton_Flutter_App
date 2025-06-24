class OrderCreateResponse {
  bool? success;
  String? message;
  OrderData? data;

  OrderCreateResponse({this.success, this.message, this.data});

  OrderCreateResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new OrderData.fromJson(json['data']) : null;
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

class OrderData {
  String? razorpayOrderId;
  num? amount;
  String? receipt;

  OrderData({this.razorpayOrderId, this.amount, this.receipt});

  OrderData.fromJson(Map<String, dynamic> json) {
    razorpayOrderId = json['razorpayOrderId'];
    amount = json['amount'];
    receipt = json['receipt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['razorpayOrderId'] = this.razorpayOrderId;
    data['amount'] = this.amount;
    data['receipt'] = this.receipt;
    return data;
  }
}