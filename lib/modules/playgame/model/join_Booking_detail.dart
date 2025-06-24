import '../../courtscreens/models/BookingResponseModel.dart';
import '../../creategames/model/AllBookingsResponseModel.dart';
import '../../creategames/model/BookingResponseModel.dart';

class JoinBookingDetail {
  bool? success;
  String? message;
  JoinBookingData? data;

  JoinBookingDetail({this.success, this.message, this.data});

  JoinBookingDetail.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new JoinBookingData.fromJson(json['data']) : null;
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

class JoinBookingData {
  String? sId;
  String? userId;
  String? gameType;
  bool? askToJoin;
  bool? isCompetitive;
  num? skillRequired;
  List<Team1>? team1;
  List<Team1>? team2;
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
  String? createdAt;
  String? updatedAt;

  JoinBookingData(
      {this.sId,
        this.userId,
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
        this.expectedPayment,
        this.cancellationReason,
        this.isMaintenance,
        this.maintenanceReason,
        this.iV,
        this.createdAt,
        this.updatedAt});

  JoinBookingData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
    venueId =
    json['venueId'] != null ? new VenueId.fromJson(json['venueId']) : null;
    courtId =
    json['courtId'] != null ? new CourtId.fromJson(json['courtId']) : null;
    bookingType = json['bookingType'];
    bookingAmount = json['bookingAmount'];
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
    return data;
  }
}



