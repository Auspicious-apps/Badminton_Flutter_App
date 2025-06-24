import 'AllBookingsResponseModel.dart';

class UpcomingBookingResponseModel {
  bool? success;
  String? message;
  List<AllBookingData>? data;

  UpcomingBookingResponseModel({this.success, this.message, this.data});

  UpcomingBookingResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    message = json['message'] as String?;
    if (json['data'] != null) {
      data = <AllBookingData>[];
      json['data'].forEach((v) {
        data!.add(AllBookingData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllBookingData {
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
  bool? isMaintenance;
  String? cancellationReason;
  String? maintenanceReason;
  int? iV;
  String? createdAt;
  String? updatedAt;
  Score? score;
  String? status;

  AllBookingData({
    this.sId,
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
    this.isMaintenance,
    this.cancellationReason,
    this.maintenanceReason,
    this.iV,
    this.createdAt,
    this.updatedAt,
    this.score,
    this.status,
  });

  AllBookingData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] as String?;
    userId = json['userId'] as String?;
    gameType = json['gameType'] as String?;
    askToJoin = json['askToJoin'] as bool?;
    isCompetitive = json['isCompetitive'] as bool?;
    skillRequired = json['skillRequired'] as num?;
    if (json['team1'] != null) {
      team1 = <Team1>[];
      json['team1'].forEach((v) {
        team1!.add(Team1.fromJson(v));
      });
    }
    if (json['team2'] != null) {
      team2 = <Team1>[];
      json['team2'].forEach((v) {
        team2!.add(Team1.fromJson(v));
      });
    }
    venueId = json['venueId'] != null ? VenueId.fromJson(json['venueId']) : null;
    courtId = json['courtId'] != null ? CourtId.fromJson(json['courtId']) : null;
    bookingType = json['bookingType'] as String?;
    bookingAmount = json['bookingAmount'] as num?;
    bookingPaymentStatus = json['bookingPaymentStatus'] as bool?;
    bookingDate = json['bookingDate'] as String?;
    bookingSlots = json['bookingSlots'] as String?;
    expectedPayment = json['expectedPayment'] as num?;
    isMaintenance = json['isMaintenance'] as bool?;
    cancellationReason = json['cancellationReason'] as String?;
    maintenanceReason = json['maintenanceReason'] as String?;
    iV = json['__v'] as int?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    score = json['score'] != null ? Score.fromJson(json['score']) : null;
    status = json['status'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['gameType'] = gameType;
    data['askToJoin'] = askToJoin;
    data['isCompetitive'] = isCompetitive;
    data['skillRequired'] = skillRequired;
    if (team1 != null) {
      data['team1'] = team1!.map((v) => v.toJson()).toList();
    }
    if (team2 != null) {
      data['team2'] = team2!.map((v) => v.toJson()).toList();
    }
    if (venueId != null) {
      data['venueId'] = venueId!.toJson();
    }
    if (courtId != null) {
      data['courtId'] = courtId!.toJson();
    }
    data['bookingType'] = bookingType;
    data['bookingAmount'] = bookingAmount;
    data['bookingPaymentStatus'] = bookingPaymentStatus;
    data['bookingDate'] = bookingDate;
    data['bookingSlots'] = bookingSlots;
    data['expectedPayment'] = expectedPayment;
    data['isMaintenance'] = isMaintenance;
    data['cancellationReason'] = cancellationReason;
    data['maintenanceReason'] = maintenanceReason;
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (score != null) {
      data['score'] = score!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class Team1 {
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

  Team1({
    this.playerId,
    this.playerType,
    this.playerPayment,
    this.paymentStatus,
    this.transactionId,
    this.paidBy,
    this.rackets,

    this.balls,
    this.sId,
    this.playerData,
  });

  Team1.fromJson(Map<String, dynamic> json) {
    playerId = json['playerId'] as String?;
    playerType = json['playerType'] as String?;
    playerPayment = json['playerPayment'] as num?;
    paymentStatus = json['paymentStatus'] as String?;
    transactionId = json['transactionId'] as String?;
    paidBy = json['paidBy'] as String?;
    rackets = json['rackets'] as num?;

    balls = json['balls'] as num?;
    sId = json['_id'] as String?;
    playerData = json['playerData'] != null ? PlayerData.fromJson(json['playerData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['playerId'] = playerId;
    data['playerType'] = playerType;
    data['playerPayment'] = playerPayment;
    data['paymentStatus'] = paymentStatus;
    data['transactionId'] = transactionId;
    data['paidBy'] = paidBy;
    data['racketA'] = rackets;

    data['balls'] = balls;
    data['_id'] = sId;
    if (playerData != null) {
      data['playerData'] = playerData!.toJson();
    }
    return data;
  }
}

class PlayerData {
  String? sId;
  String? name;
  String? fullName;
  String? profilePic;
  String? image;

  PlayerData({this.sId, this.name, this.profilePic, this.image, this.fullName});

  PlayerData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] as String?;
    name = json['name'] as String?;
    fullName = json['fullName'] as String?;
    profilePic = json['profilePic'] as String?;
    image = json['image'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['fullName'] = fullName;
    data['profilePic'] = profilePic;
    data['image'] = image;
    return data;
  }
}

class VenueId {
  String? sId;
  String? name;
  String? address;
  String? city;
  String? state;
  String? image;

  VenueId({this.sId, this.name, this.address, this.city, this.state,this.image});

  VenueId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] as String?;
    name = json['name'] as String?;
    address = json['address'] as String?;
    city = json['city'] as String?;
    state = json['state'] as String?;
    image = json['image'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['image'] = image;

    return data;
  }
}

class CourtId {
  String? sId;
  String? games;

  CourtId({this.sId, this.games});

  CourtId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] as String?;
    games = json['games'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['games'] = games;
    return data;
  }
}

