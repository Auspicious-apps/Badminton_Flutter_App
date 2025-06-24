class JoinOpenMatchResponseModel {
  bool? success;
  String? message;
  JoinData? data;

  JoinOpenMatchResponseModel({this.success, this.message, this.data});

  JoinOpenMatchResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new JoinData.fromJson(json['data']) : null;
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

class JoinData {
  // Request? request;
  // Transaction? transaction;
  Payment? payment;

  JoinData({
    // this.request,
    // this.transaction,
    this.payment});

  JoinData.fromJson(Map<String, dynamic> json) {
    // request =
    // json['request'] != null ? new Request.fromJson(json['request']) : null;
    // transaction = json['transaction'] != null
    //     ? new Transaction.fromJson(json['transaction'])
    //     : null;
    payment =
    json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.request != null) {
    //   data['request'] = this.request!.toJson();
    // }
    // if (this.transaction != null) {
    //   data['transaction'] = this.transaction!.toJson();
    // }
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    return data;
  }
}

// class Request {
//   String? bookingId;
//   String? requestedTo;
//   String? requestedBy;
//   String? requestedTeam;
//   String? requestedPosition;
//   String? status;
//   int? racketA;
//   int? racketB;
//   int? racketC;
//   int? balls;
//   num? playerPayment;
//   String? paymentStatus;
//   String? bookingStatus;
//   String? transactionId;
//   String? sId;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//
//   Request(
//       {this.bookingId,
//         this.requestedTo,
//         this.requestedBy,
//         this.requestedTeam,
//         this.requestedPosition,
//         this.status,
//         this.racketA,
//         this.racketB,
//         this.racketC,
//         this.balls,
//         this.playerPayment,
//         this.paymentStatus,
//         this.bookingStatus,
//         this.transactionId,
//         this.sId,
//         this.createdAt,
//         this.updatedAt,
//         this.iV});
//
//   Request.fromJson(Map<String, dynamic> json) {
//     bookingId = json['bookingId'];
//     requestedTo = json['requestedTo'];
//     requestedBy = json['requestedBy'];
//     requestedTeam = json['requestedTeam'];
//     requestedPosition = json['requestedPosition'];
//     status = json['status'];
//     racketA = json['racketA'];
//     racketB = json['racketB'];
//     racketC = json['racketC'];
//     balls = json['balls'];
//     playerPayment = json['playerPayment'];
//     paymentStatus = json['paymentStatus'];
//     bookingStatus = json['bookingStatus'];
//     transactionId = json['transactionId'];
//     sId = json['_id'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['bookingId'] = this.bookingId;
//     data['requestedTo'] = this.requestedTo;
//     data['requestedBy'] = this.requestedBy;
//     data['requestedTeam'] = this.requestedTeam;
//     data['requestedPosition'] = this.requestedPosition;
//     data['status'] = this.status;
//     data['racketA'] = this.racketA;
//     data['racketB'] = this.racketB;
//     data['racketC'] = this.racketC;
//     data['balls'] = this.balls;
//     data['playerPayment'] = this.playerPayment;
//     data['paymentStatus'] = this.paymentStatus;
//     data['bookingStatus'] = this.bookingStatus;
//     data['transactionId'] = this.transactionId;
//     data['_id'] = this.sId;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }

// class Transaction {
//   String? userId;
//   List<String>? bookingId;
//   List<String>? paidFor;
//   // Null? razorpayOrderId;
//   // Null? razorpayPaymentId;
//   // Null? razorpaySignature;
//   double? amount;
//   String? currency;
//   String? status;
//   String? method;
//   Notes? notes;
//   bool? isWebhookVerified;
//   int? playcoinsUsed;
//   int? refundedAmount;
//   Null? refundId;
//   Null? failureReason;
//   String? sId;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//
//   Transaction(
//       {this.userId,
//         this.bookingId,
//         this.paidFor,
//         // this.razorpayOrderId,
//         // this.razorpayPaymentId,
//         // this.razorpaySignature,
//         this.amount,
//         this.currency,
//         this.status,
//         this.method,
//         this.notes,
//         this.isWebhookVerified,
//         this.playcoinsUsed,
//         this.refundedAmount,
//         this.refundId,
//         this.failureReason,
//         this.sId,
//         this.createdAt,
//         this.updatedAt,
//         this.iV});
//
//   Transaction.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     bookingId = json['bookingId'].cast<String>();
//     paidFor = json['paidFor'].cast<String>();
//     // razorpayOrderId = json['razorpayOrderId'];
//     // razorpayPaymentId = json['razorpayPaymentId'];
//     // razorpaySignature = json['razorpaySignature'];
//     amount = json['amount'];
//     currency = json['currency'];
//     status = json['status'];
//     method = json['method'];
//     notes = json['notes'] != null ? new Notes.fromJson(json['notes']) : null;
//     isWebhookVerified = json['isWebhookVerified'];
//     playcoinsUsed = json['playcoinsUsed'];
//     refundedAmount = json['refundedAmount'];
//     refundId = json['refundId'];
//     failureReason = json['failureReason'];
//     sId = json['_id'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userId'] = this.userId;
//     data['bookingId'] = this.bookingId;
//     data['paidFor'] = this.paidFor;
//     // data['razorpayOrderId'] = this.razorpayOrderId;
//     // data['razorpayPaymentId'] = this.razorpayPaymentId;
//     // data['razorpaySignature'] = this.razorpaySignature;
//     data['amount'] = this.amount;
//     data['currency'] = this.currency;
//     data['status'] = this.status;
//     data['method'] = this.method;
//     if (this.notes != null) {
//       data['notes'] = this.notes!.toJson();
//     }
//     data['isWebhookVerified'] = this.isWebhookVerified;
//     data['playcoinsUsed'] = this.playcoinsUsed;
//     data['refundedAmount'] = this.refundedAmount;
//     data['refundId'] = this.refundId;
//     data['failureReason'] = this.failureReason;
//     data['_id'] = this.sId;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }

class Notes {
  String? bookingSlot;
  String? requestedTeam;
  String? requestedPosition;
  int? racketA;
  int? racketB;
  int? racketC;
  int? balls;

  Notes(
      {this.bookingSlot,
        this.requestedTeam,
        this.requestedPosition,
        this.racketA,
        this.racketB,
        this.racketC,
        this.balls});

  Notes.fromJson(Map<String, dynamic> json) {
    bookingSlot = json['bookingSlot'];
    requestedTeam = json['requestedTeam'];
    requestedPosition = json['requestedPosition'];
    racketA = json['racketA'];
    racketB = json['racketB'];
    racketC = json['racketC'];
    balls = json['balls'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingSlot'] = this.bookingSlot;
    data['requestedTeam'] = this.requestedTeam;
    data['requestedPosition'] = this.requestedPosition;
    data['racketA'] = this.racketA;
    data['racketB'] = this.racketB;
    data['racketC'] = this.racketC;
    data['balls'] = this.balls;
    return data;
  }
}

class Payment {
  String? razorpayOrderId;
  num? amount;
  num? playcoinsUsed;
  String? currency;

  Payment(
      {this.razorpayOrderId, this.amount, this.playcoinsUsed, this.currency});

  Payment.fromJson(Map<String, dynamic> json) {
    razorpayOrderId = json['razorpayOrderId'];
    amount = json['amount'];
    playcoinsUsed = json['playcoinsUsed'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['razorpayOrderId'] = this.razorpayOrderId;
    data['amount'] = this.amount;
    data['playcoinsUsed'] = this.playcoinsUsed;
    data['currency'] = this.currency;
    return data;
  }
}