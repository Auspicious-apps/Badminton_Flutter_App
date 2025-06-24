import '../../courtscreens/models/BookingResponseModel.dart';
import '../../creategames/model/BookingResponseModel.dart';

class HomeDataModel {
  bool? success;
  String? message;
  HomeData? data;

  HomeDataModel({this.success, this.message, this.data});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new HomeData.fromJson(json['data']) : null;
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

class HomeData {

  List<VenueNearby>? venueNearby;
  List<UpcomingMatches>? upcomingMatches;
  LoyaltyPoints? loyaltyPoints;
  List<String>? banners;
  HomeData(
      {
        this.venueNearby,
        this.upcomingMatches,
        this.banners,
        this.loyaltyPoints});

  HomeData.fromJson(Map<String, dynamic> json) {

    banners = json['banners'].cast<String>();
    if (json['venueNearby'] != null) {
      venueNearby = <VenueNearby>[];
      json['venueNearby'].forEach((v) {
        venueNearby!.add(new VenueNearby.fromJson(v));
      });
    }

    if (json['upcomingMatches'] != null) {
      upcomingMatches = <UpcomingMatches>[];
      json['upcomingMatches'].forEach((v) {
        upcomingMatches!.add(new UpcomingMatches.fromJson(v));
      });
    }
    loyaltyPoints = json['loyaltyPoints'] != null
        ? new LoyaltyPoints.fromJson(json['loyaltyPoints'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banners'] = this.banners;
    if (this.venueNearby != null) {
      data['venueNearby'] = this.venueNearby!.map((v) => v.toJson()).toList();
    }
    if (this.upcomingMatches != null) {
      data['upcomingMatches'] =
          this.upcomingMatches!.map((v) => v.toJson()).toList();
    }
    if (this.loyaltyPoints != null) {
      data['loyaltyPoints'] = this.loyaltyPoints!.toJson();
    }
    return data;
  }
}

class UpcomingMatches {
  String? sId;
  String? userId;
  String? gameType;
  bool? askToJoin;
  bool? isCompetitive;
  int? skillRequired;
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
  bool? isMaintenance;
  String? maintenanceReason;
  int? iV;
  String? createdAt;
  String? updatedAt;

  UpcomingMatches(
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
        this.cancellationReason,
        this.isMaintenance,
        this.maintenanceReason,
        this.iV,
        this.createdAt,
        this.updatedAt});

  UpcomingMatches.fromJson(Map<String, dynamic> json) {
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
    venueId = json['venueId'];
    courtId = json['courtId'];
    bookingType = json['bookingType'];
    bookingAmount = json['bookingAmount'];
    bookingPaymentStatus = json['bookingPaymentStatus'];
    bookingDate = json['bookingDate'];
    bookingSlots = json['bookingSlots'];
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
    data['venueId'] = this.venueId;
    data['courtId'] = this.courtId;
    data['bookingType'] = this.bookingType;
    data['bookingAmount'] = this.bookingAmount;
    data['bookingPaymentStatus'] = this.bookingPaymentStatus;
    data['bookingDate'] = this.bookingDate;
    data['bookingSlots'] = this.bookingSlots;
    data['cancellationReason'] = this.cancellationReason;
    data['isMaintenance'] = this.isMaintenance;
    data['maintenanceReason'] = this.maintenanceReason;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class VenueNearby {
  String? sId;
  String? name;
  String? city;
  String? state;
  String? image;
  Weather? weather;
  num? distance;

  VenueNearby(
      {this.sId,
        this.name,
        this.city,
        this.state,
        this.image,
        this.weather,
        this.distance});

  VenueNearby.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    city = json['city'];
    state = json['state'];
    image = json['image'];
    weather =
    json['weather'] != null ? new Weather.fromJson(json['weather']) : null;
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['city'] = this.city;
    data['state'] = this.state;
    data['image'] = this.image;
    if (this.weather != null) {
      data['weather'] = this.weather!.toJson();
    }
    data['distance'] = this.distance;
    return data;
  }
}

class Weather {
  String? status;
  String? icon;
  num? temperature;
  String? lastUpdated;

  Weather({this.status, this.icon, this.temperature, this.lastUpdated});

  Weather.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    icon = json['icon'];
    temperature = json['temperature'];
    lastUpdated = json['lastUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['icon'] = this.icon;
    data['temperature'] = this.temperature;
    data['lastUpdated'] = this.lastUpdated;
    return data;
  }
}

class LoyaltyPoints {
  num? points;
  num? level;
  num? totalLevels;
  num? freeGames;

  LoyaltyPoints({this.points, this.level, this.totalLevels,this.freeGames});

  LoyaltyPoints.fromJson(Map<String, dynamic> json) {
    points = json['points'];
    level = json['level'];
    totalLevels = json['totalLevels'];
    freeGames = json['freeGames'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = this.points;
    data['level'] = this.level;
    data['totalLevels'] = this.totalLevels;
    data['freeGames'] = this.freeGames;
    return data;
  }
}