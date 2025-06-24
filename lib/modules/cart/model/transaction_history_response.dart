class TransactionResponseModel {
  bool? success;
  String? message;
  TransactionData? data;


  TransactionResponseModel({this.success, this.message, this.data});

  TransactionResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new TransactionData.fromJson(json['data']) : null;

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

class TransactionData {
  num? totalPlayCoinsBalance;
  num? totalMatches;
  List<TransactionHistory>? transactionHistory;

  TransactionData(
      {this.totalPlayCoinsBalance, this.totalMatches, this.transactionHistory});

  TransactionData.fromJson(Map<String, dynamic> json) {
    totalPlayCoinsBalance = json['totalPlayCoinsBalance'];
    totalMatches = json['totalMatches'];
    if (json['transactionHistory'] != null) {
      transactionHistory = <TransactionHistory>[];
      json['transactionHistory'].forEach((v) {
        transactionHistory!.add(new TransactionHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPlayCoinsBalance'] = this.totalPlayCoinsBalance;
    data['totalMatches'] = this.totalMatches;
    if (this.transactionHistory != null) {
      data['transactionHistory'] =
          this.transactionHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionHistory {
  String? sId;
  String? text;
  num? amount;
  String? status;

  num? playcoinsUsed;
  String? createdAt;
  String? transactionType;
  String? paymentMethod;
  PaymentBreakdown? paymentBreakdown;

  TransactionHistory(
      {this.sId,
        this.text,
        this.amount,
        this.status,

        this.playcoinsUsed,
        this.createdAt,
        this.transactionType,
        this.paymentMethod,
        this.paymentBreakdown});

  TransactionHistory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    text = json['text'];
    amount = json['amount'];
    status = json['status'];

    playcoinsUsed = json['playcoinsUsed'];
    createdAt = json['createdAt'];
    transactionType = json['transactionType'];
    paymentMethod = json['paymentMethod'];
    paymentBreakdown = json['paymentBreakdown'] != null
        ? new PaymentBreakdown.fromJson(json['paymentBreakdown'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['text'] = this.text;
    data['amount'] = this.amount;
    data['status'] = this.status;

    data['playcoinsUsed'] = this.playcoinsUsed;
    data['createdAt'] = this.createdAt;
    data['transactionType'] = this.transactionType;
    data['paymentMethod'] = this.paymentMethod;
    if (this.paymentBreakdown != null) {
      data['paymentBreakdown'] = this.paymentBreakdown!.toJson();
    }
    return data;
  }
}

class PaymentBreakdown {
  num? totalAmount;
  num? moneyPaid;
  num? playcoinsUsed;

  PaymentBreakdown({this.totalAmount, this.moneyPaid, this.playcoinsUsed});

  PaymentBreakdown.fromJson(Map<String, dynamic> json) {
    totalAmount = json['totalAmount'];
    moneyPaid = json['moneyPaid'];
    playcoinsUsed = json['playcoinsUsed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalAmount'] = this.totalAmount;
    data['moneyPaid'] = this.moneyPaid;
    data['playcoinsUsed'] = this.playcoinsUsed;
    return data;
  }
}






