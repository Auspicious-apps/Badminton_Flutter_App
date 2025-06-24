import '../../creategames/model/AllBookingsResponseModel.dart';
import '../../creategames/model/BookingResponseModel.dart' show Team1;
import '../../home /models/getOpenResponseModel.dart';

class GetUserIdResponseModel {
  bool? success;
  String? message;
  UserByIdData? data;

  GetUserIdResponseModel({this.success, this.message, this.data});

  GetUserIdResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new UserByIdData.fromJson(json['data']) : null;
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
class PreviousMatches {
  String? matchId;
  String? date;
  String? time;
  Venue? venue;
  Court? court;
  String? matchType;
  List<Team1>? team1;
  List<Team1>? team2;
  Score? score;
  bool?isCompetitive;

  PreviousMatches({this.matchId, this.date, this.time, this.venue, this.court, this.matchType, this.team1, this.team2, this.score,this.isCompetitive});

  PreviousMatches.fromJson(Map<String, dynamic> json) {
    matchId = json['matchId'];
    date = json['date'];
    time = json['time'];
    venue = json['venue'] != null ? new Venue.fromJson(json['venue']) : null;
    isCompetitive = json['isCompetitive'];
    matchType = json['matchType'];
    if (json['team1'] != null) {
      team1 = <Team1>[];
      json['team1'].forEach((v) { team1!.add(new Team1.fromJson(v)); });
    }
    if (json['team2'] != null) {
      team2 = <Team1>[];
      json['team2'].forEach((v) { team2!.add(new Team1.fromJson(v)); });
    }
    score = json['score'] != null ? new Score.fromJson(json['score']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['matchId'] = this.matchId;
    data['date'] = this.date;
    data['time'] = this.time;
    data['isCompetitive'] = this.isCompetitive;
    if (this.venue != null) {
      data['venue'] = this.venue!.toJson();
    }
    if (this.court != null) {
      data['court'] = this.court!.toJson();
    }
    data['matchType'] = this.matchType;
    if (this.team1 != null) {
      data['team1'] = this.team1!.map((v) => v.toJson()).toList();
    }
    if (this.team2 != null) {
      data['team2'] = this.team2!.map((v) => v.toJson()).toList();
    }
    if (this.score != null) {
      data['score'] = this.score!.toJson();
    }
    return data;
  }
}

class UserByIdData {
  String? sId;
  String? profilePic;
  String? fullName;
  Stats? stats;
  String? friendshipStatus;
  bool? isFriend;
  String? relationshipId;
  List<PreviousMatches>? previousMatches;
  UserByIdData(
      {this.sId,
        this.profilePic,
        this.fullName,
        this.stats,
        this.friendshipStatus,
        this.isFriend,
        this.previousMatches,
        this.relationshipId});

  UserByIdData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePic = json['profilePic'];
    fullName = json['fullName'];
    stats = json['stats'] != null ? new Stats.fromJson(json['stats']) : null;
    friendshipStatus = json['friendshipStatus'];
    isFriend = json['isFriend'];
    relationshipId = json['relationshipId'];
    if (json['previousMatches'] != null) {
      previousMatches = <PreviousMatches>[];
      json['previousMatches'].forEach((v) { previousMatches!.add(new PreviousMatches.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profilePic'] = this.profilePic;
    data['fullName'] = this.fullName;
    if (this.stats != null) {
      data['stats'] = this.stats!.toJson();
    }
    data['friendshipStatus'] = this.friendshipStatus;
    data['isFriend'] = this.isFriend;
    data['relationshipId'] = this.relationshipId;
    if (this.previousMatches != null) {
      data['previousMatches'] = this.previousMatches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}




class Stats {
  num? totalMatches;
  num? padlelMatches;
  num? pickleballMatches;
  num? loyaltyPoints;
  num? level;
  num? lastMonthLevel;
  num? level6MonthsAgo;
  num? level1YearAgo;
  num? improvement;
  String? confidence;

  Stats(
      {this.totalMatches,
        this.padlelMatches,
        this.pickleballMatches,
        this.loyaltyPoints,
        this.level,
        this.lastMonthLevel,
        this.level6MonthsAgo,
        this.level1YearAgo,
        this.improvement,
        this.confidence});

  Stats.fromJson(Map<String, dynamic> json) {
    totalMatches = json['totalMatches'];
    padlelMatches = json['padlelMatches'];
    pickleballMatches = json['pickleballMatches'];
    loyaltyPoints = json['loyaltyPoints'];
    level = json['level'];
    lastMonthLevel = json['lastMonthLevel'];
    level6MonthsAgo = json['level6MonthsAgo'];
    level1YearAgo = json['level1YearAgo'];
    improvement = json['improvement'];
    confidence = json['confidence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalMatches'] = this.totalMatches;
    data['padlelMatches'] = this.padlelMatches;
    data['pickleballMatches'] = this.pickleballMatches;
    data['loyaltyPoints'] = this.loyaltyPoints;
    data['level'] = this.level;
    data['lastMonthLevel'] = this.lastMonthLevel;
    data['level6MonthsAgo'] = this.level6MonthsAgo;
    data['level1YearAgo'] = this.level1YearAgo;
    data['improvement'] = this.improvement;
    data['confidence'] = this.confidence;
    return data;
  }
}