class PaymentResponseModel {
  bool? success;
  String? message;
  PaymentData? data;

  PaymentResponseModel({this.success, this.message, this.data});

  PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new PaymentData.fromJson(json['data']) : null;
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

class PaymentData {
  String? razorpayOrderId;
  num? amount;
  String? currency;
  String? receipt;

  PaymentData({this.razorpayOrderId, this.amount, this.currency, this.receipt});

  PaymentData.fromJson(Map<String, dynamic> json) {
    razorpayOrderId = json['razorpayOrderId'];
    amount = json['amount'];
    currency = json['currency'];
    receipt = json['receipt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['razorpayOrderId'] = this.razorpayOrderId;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['receipt'] = this.receipt;
    return data;
  }
}

