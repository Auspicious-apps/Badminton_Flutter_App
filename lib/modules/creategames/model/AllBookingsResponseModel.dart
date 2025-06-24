import '../../courtscreens/models/BookingResponseModel.dart';
import 'BookingResponseModel.dart';

class AllBookingResponseModel {
  bool? success;
  String? message;
  BookingData? data;

  AllBookingResponseModel({this.success, this.message, this.data});

  AllBookingResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Previous>? previous;
  List<Previous>? current;

  BookingData({this.previous, this.current});

  BookingData.fromJson(Map<String, dynamic> json) {
    if (json['previous'] != null) {
      previous = <Previous>[];
      json['previous'].forEach((v) { previous!.add(new Previous.fromJson(v)); });
    }
    if (json['current'] != null) {
      current = <Previous>[];
      json['current'].forEach((v) { current!.add(new Previous.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.previous != null) {
      data['previous'] = this.previous!.map((v) => v.toJson()).toList();
    }
    if (this.current != null) {
      data['current'] = this.current!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Previous {
  String? sId;
  String? gameType;
  String? bookingType;
  bool? isCompetitive;
  bool? askToJoin;
  num? skillRequired;
  List<Team1>? team1;
  List<Team1>? team2;
  VenueId? venueId;
  CourtId? courtId;
  String? bookingDate;

  String? bookingSlots;
  Score? score;

  Previous({this.sId, this.gameType,this.askToJoin,this.bookingType, this.isCompetitive, this.skillRequired, this.team1, this.team2, this.venueId, this.courtId, this.bookingDate, this.bookingSlots, this.score});

  Previous.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gameType = json['gameType'];
    isCompetitive = json['isCompetitive'];
    bookingType = json['bookingType'];
    askToJoin = json['askToJoin'];
    skillRequired = json['skillRequired'];
    if (json['team1'] != null) {
      team1 = <Team1>[];
      json['team1'].forEach((v) { team1!.add(new Team1.fromJson(v)); });
    }
    if (json['team2'] != null) {
      team2 = <Team1>[];
      json['team2'].forEach((v) { team2!.add(new Team1.fromJson(v)); });
    }
    venueId = json['venueId'] != null ? new VenueId.fromJson(json['venueId']) : null;
    courtId = json['courtId'] != null ? new CourtId.fromJson(json['courtId']) : null;
    bookingDate = json['bookingDate'];
    bookingSlots = json['bookingSlots'];
    score = json['score'] != null ? new Score.fromJson(json['score']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['gameType'] = this.gameType;
    data['bookingType'] = this.bookingType;
    data['isCompetitive'] = this.isCompetitive;
    data['askToJoin'] = this.askToJoin;
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
    data['bookingDate'] = this.bookingDate;
    data['bookingSlots'] = this.bookingSlots;
    if (this.score != null) {
      data['score'] = this.score!.toJson();
    }
    return data;
  }
}


//
// class VenueId {
//   String? sId;
//   String? name;
//   String? address;
//   String? city;
//   String? state;
//
//   VenueId({this.sId, this.name, this.address, this.city, this.state});
//
//   VenueId.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     address = json['address'];
//     city = json['city'];
//     state = json['state'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['address'] = this.address;
//     data['city'] = this.city;
//     data['state'] = this.state;
//     return data;
//   }
// }
//
// class CourtId {
//   String? sId;
//   String? games;
//
//   CourtId({this.sId, this.games});
//
//   CourtId.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     games = json['games'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['games'] = this.games;
//     return data;
//   }
// }


class Score {
String? sId;
String? bookingId;
Set1? set1;
Set1? set2;
Set1? set3;
String? createdAt;
String? updatedAt;
int? iV;

Score({this.sId, this.bookingId, this.set1, this.set2, this.set3, this.createdAt, this.updatedAt, this.iV});

Score.fromJson(Map<String, dynamic> json) {
sId = json['_id'];
bookingId = json['bookingId'];
set1 = json['set1'] != null ? new Set1.fromJson(json['set1']) : null;
set2 = json['set2'] != null ? new Set1.fromJson(json['set2']) : null;
set3 = json['set3'] != null ? new Set1.fromJson(json['set3']) : null;
createdAt = json['createdAt'];
updatedAt = json['updatedAt'];
iV = json['__v'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['_id'] = this.sId;
data['bookingId'] = this.bookingId;
if (this.set1 != null) {
data['set1'] = this.set1!.toJson();
}
if (this.set2 != null) {
data['set2'] = this.set2!.toJson();
}
if (this.set3 != null) {
data['set3'] = this.set3!.toJson();
}
data['createdAt'] = this.createdAt;
data['updatedAt'] = this.updatedAt;
data['__v'] = this.iV;
return data;
}
}

class Set1 {
num? team1;
num? team2;

Set1({this.team1, this.team2});

Set1.fromJson(Map<String, dynamic> json) {
team1 = json['team1'];
team2 = json['team2'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['team1'] = this.team1;
data['team2'] = this.team2;
return data;
}
}

