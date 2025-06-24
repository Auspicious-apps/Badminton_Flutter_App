import '../../creategames/model/AllBookingsResponseModel.dart';
import '../../creategames/model/BookingResponseModel.dart';

class BookingDetailModel  {
  bool? success;
  String? message;
  BookingDetailData? data;

  BookingDetailModel ({this.success, this.message, this.data});

  BookingDetailModel .fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new BookingDetailData.fromJson(json['data']) : null;
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

class BookingDetailData {
  String? sId;
  String? userId;
  String? gameType;
  bool? askToJoin;
  bool? isCompetitive;
  num? skillRequired;
  num? rackets;
  num? balls;
  List<Teams>? team1;
  List<Teams>? team2;
  VenueId? venueId;
  CourtId? courtId;
  String? bookingType;
  num? bookingAmount;
  bool? bookingPaymentStatus;
  String? bookingDate;
  String? bookingSlots;
  num? expectedPayment;
  String? cancellationReason;
  bool? isMaintenance;
  String? maintenanceReason;
  num? iV;
  Score? score;
  String? createdAt;
  String? updatedAt;


  BookingDetailData({this.sId, this.userId, this.gameType,this.rackets,this.balls, this.askToJoin, this.isCompetitive, this.skillRequired, this.team1, this.team2, this.venueId, this.courtId, this.bookingType, this.bookingAmount, this.bookingPaymentStatus, this.bookingDate, this.bookingSlots, this.expectedPayment, this.cancellationReason, this.isMaintenance, this.maintenanceReason, this.iV, this.createdAt, this.updatedAt,this.score});

  BookingDetailData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    gameType = json['gameType'];
    askToJoin = json['askToJoin'];
    rackets = json['rackets'];
    balls = json['balls'];
    isCompetitive = json['isCompetitive'];
    skillRequired = json['skillRequired'];
    if (json['team1'] != null) {
      team1 = <Teams>[];
      json['team1'].forEach((v) { team1!.add(new Teams.fromJson(v)); });
    }
    if (json['team2'] != null) {
      team2 = <Teams>[];
      json['team2'].forEach((v) { team2!.add(new Teams.fromJson(v)); });
    }
    venueId = json['venueId'] != null ? new VenueId.fromJson(json['venueId']) : null;
    courtId = json['courtId'] != null ? new CourtId.fromJson(json['courtId']) : null;
    bookingType = json['bookingType'];
    bookingAmount = json['bookingAmount'];
    score = json['score'] != null ? new Score.fromJson(json['score']) : null;
    bookingPaymentStatus = json['bookingPaymentStatus'];
    bookingDate = json['bookingDate'];
    bookingSlots = json['bookingSlots'];
    expectedPayment = json['expectedPayment'];
    cancellationReason = json['cancellationReason'];
    isMaintenance = json['isMaintenance'];
    maintenanceReason = json['maintenanceReason'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['gameType'] = this.gameType;
    data['rackets'] = this.rackets;
    data['balls'] = this.balls;
    data['askToJoin'] = this.askToJoin;
    data['isCompetitive'] = this.isCompetitive;
    data['skillRequired'] = this.skillRequired;
    if (this.team1 != null) {
      data['team1'] = this.team1!.map((v) => v.toJson()).toList();
    }
    if (this.team2 != null) {
      data['team2'] = this.team2!.map((v) => v.toJson()).toList();
    }
    if (this.venueId != null) {
      data['venueId'] = this.venueId!.toJson();
    }
    if (this.courtId != null) {
      data['courtId'] = this.courtId!.toJson();
    }
    data['bookingType'] = this.bookingType;
    data['bookingAmount'] = this.bookingAmount;
    data['bookingPaymentStatus'] = this.bookingPaymentStatus;
    data['bookingDate'] = this.bookingDate;
    data['bookingSlots'] = this.bookingSlots;

    data['expectedPayment'] = this.expectedPayment;
    data['cancellationReason'] = this.cancellationReason;
    data['isMaintenance'] = this.isMaintenance;
    data['maintenanceReason'] = this.maintenanceReason;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.score != null) {
      data['score'] = this.score!.toJson();
    }
    return data;
  }
}

class Teams {
  String? playerId;
  String? playerType;
  num? playerPayment;
  String? paymentStatus;
  String? transactionId;
  String? paidBy;
  num? rackets;
  num? balls;
  String? sId;
  PlayerData? playerData;

  Teams({this.playerId, this.playerType, this.playerPayment, this.paymentStatus, this.transactionId, this.paidBy, this.rackets, this.balls, this.sId, this.playerData});

  Teams.fromJson(Map<String, dynamic> json) {
    playerId = json['playerId'];
    playerType = json['playerType'];
    playerPayment = json['playerPayment'];
    paymentStatus = json['paymentStatus'];
    transactionId = json['transactionId'];
    paidBy = json['paidBy'];
    rackets = json['rackets'];
    balls = json['balls'];
    sId = json['_id'];
    playerData = json['playerData'] != null ? new PlayerData.fromJson(json['playerData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playerId'] = this.playerId;
    data['playerType'] = this.playerType;
    data['playerPayment'] = this.playerPayment;
    data['paymentStatus'] = this.paymentStatus;
    data['transactionId'] = this.transactionId;
    data['paidBy'] = this.paidBy;
    data['rackets'] = this.rackets;
    data['balls'] = this.balls;
    data['_id'] = this.sId;
    if (this.playerData != null) {
      data['playerData'] = this.playerData!.toJson();
    }
    return data;
  }
}










