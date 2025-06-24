import '../../creategames/model/BookingResponseModel.dart';

class BookingResponseModel {
  bool? success;
  String? message;
  BookingData? data;

  BookingResponseModel({this.success, this.message, this.data});

  BookingResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new BookingData.fromJson(json['data']) : null;
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

class BookingData {
  Transaction? transaction;
  List<Bookings>? bookings;

  BookingData({this.transaction, this.bookings});

  BookingData.fromJson(Map<String, dynamic> json) {
    transaction = json['transaction'] != null
        ? new Transaction.fromJson(json['transaction'])
        : null;
    if (json['bookings'] != null) {
      bookings = <Bookings>[];
      json['bookings'].forEach((v) {
        bookings!.add(new Bookings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transaction != null) {
      data['transaction'] = this.transaction!.toJson();
    }
    if (this.bookings != null) {
      data['bookings'] = this.bookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transaction {
  String? userId;
  List<String>? paidFor;
  String? razorpayPaymentId;
  String? razorpaySignature;
  num? amount;
  String? currency;
  String? status;
  String? method;
  List<String>? notes;
  bool? isWebhookVerified;
  num? refundedAmount;
  String? refundId;
  String? failureReason;
  String? sId;
  String? createdAt;
  String? updatedAt;
  num? iV;
  List<String>? bookingId;

  Transaction(
      {this.userId,
        this.paidFor,
        this.razorpayPaymentId,
        this.razorpaySignature,
        this.amount,
        this.currency,
        this.status,
        this.method,
        this.notes,
        this.isWebhookVerified,
        this.refundedAmount,
        this.refundId,
        this.failureReason,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.bookingId});

  Transaction.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    paidFor = json['paidFor'].cast<String>();
    razorpayPaymentId = json['razorpayPaymentId'];
    razorpaySignature = json['razorpaySignature'];
    amount = json['amount'];
    currency = json['currency'];
    status = json['status'];
    method = json['method'];
    notes = json['notes'].cast<String>();
    isWebhookVerified = json['isWebhookVerified'];
    refundedAmount = json['refundedAmount'];
    refundId = json['refundId'];
    failureReason = json['failureReason'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    bookingId = json['bookingId'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['paidFor'] = this.paidFor;
    data['razorpayPaymentId'] = this.razorpayPaymentId;
    data['razorpaySignature'] = this.razorpaySignature;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['status'] = this.status;
    data['method'] = this.method;
    data['notes'] = this.notes;
    data['isWebhookVerified'] = this.isWebhookVerified;
    data['refundedAmount'] = this.refundedAmount;
    data['refundId'] = this.refundId;
    data['failureReason'] = this.failureReason;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['bookingId'] = this.bookingId;
    return data;
  }
}

class Bookings {
  String? userId;
  String? gameType;
  bool? askToJoin;
  bool? isCompetitive;
  num? skillRequired;
  List<Team1>? team1;
  List<Team1>? team2;
  String? venueId;
  String? courtId;
  String? bookingType;
  num? bookingAmount;
  bool? bookingPaymentStatus;
  String? bookingDate;
  String? bookingSlots;
  String? cancellationReason;
  String? sId;
  num? iV;
  String? createdAt;
  String? updatedAt;

  Bookings(
      {this.userId,
        this.gameType,
        this.askToJoin,
        this.isCompetitive,
        this.skillRequired,
        this.team1,
        this.team2,
        this.venueId,
        this.courtId,
        this.bookingType,
        this.bookingAmount,
        this.bookingPaymentStatus,
        this.bookingDate,
        this.bookingSlots,
        this.cancellationReason,
        this.sId,
        this.iV,
        this.createdAt,
        this.updatedAt});

  Bookings.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    gameType = json['gameType'];
    askToJoin = json['askToJoin'];
    isCompetitive = json['isCompetitive'];
    skillRequired = json['skillRequired'];
    if (json['team1'] != null) {
      team1 = <Team1>[];
      json['team1'].forEach((v) {
        team1!.add(new Team1.fromJson(v));
      });
    }
    if (json['team2'] != null) {
      team2 = <Team1>[];
      json['team2'].forEach((v) {
        team2!.add(new Team1.fromJson(v));
      });
    }
    venueId = json['venueId'];
    courtId = json['courtId'];
    bookingType = json['bookingType'];
    bookingAmount = json['bookingAmount'];
    bookingPaymentStatus = json['bookingPaymentStatus'];
    bookingDate = json['bookingDate'];
    bookingSlots = json['bookingSlots'];
    cancellationReason = json['cancellationReason'];
    sId = json['_id'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['gameType'] = this.gameType;
    data['askToJoin'] = this.askToJoin;
    data['isCompetitive'] = this.isCompetitive;
    data['skillRequired'] = this.skillRequired;
    if (this.team1 != null) {
      data['team1'] = this.team1!.map((v) => v.toJson()).toList();
    }
    if (this.team2 != null) {
      data['team2'] = this.team2!.map((v) => v.toJson()).toList();
    }
    data['venueId'] = this.venueId;
    data['courtId'] = this.courtId;
    data['bookingType'] = this.bookingType;
    data['bookingAmount'] = this.bookingAmount;
    data['bookingPaymentStatus'] = this.bookingPaymentStatus;
    data['bookingDate'] = this.bookingDate;
    data['bookingSlots'] = this.bookingSlots;
    data['cancellationReason'] = this.cancellationReason;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}






