// Note: Removed conflicting imports as they were not used in the provided code.
// If BookingResponseModel is needed, ensure only the correct import is used.

class GetOpenResponseModel {
  bool? success;
  String? message;
  List<OpenMatchesData>? data;
  Meta? meta;

  GetOpenResponseModel({this.success, this.message, this.data, this.meta});

  GetOpenResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    message = json['message'] as String?;
    if (json['data'] != null) {
      data = <OpenMatchesData>[];
      json['data'].forEach((v) {
        data!.add(OpenMatchesData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class OpenMatchesData {
  String? sId;
  String? bookingDate;
  String? formattedDate;
  List<String>? bookingSlots;
  bool? askToJoin;
  bool? isCompetitive;
  num? skillRequired;
  List<DataTeam1>? team1;
  List<DataTeam1>? team2;
  Venue? venue;
  Court? court;
  double? distance;

  OpenMatchesData({
    this.sId,
    this.bookingDate,
    this.formattedDate,
    this.bookingSlots,
    this.askToJoin,
    this.isCompetitive,
    this.skillRequired,
    this.team1,
    this.team2,
    this.venue,
    this.court,
    this.distance,
  });

  OpenMatchesData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] as String?;
    bookingDate = json['bookingDate'] as String?;
    formattedDate = json['formattedDate'] as String?;
    bookingSlots = (json['bookingSlots'] as List<dynamic>?)?.cast<String>();
    askToJoin = json['askToJoin'] as bool?;
    isCompetitive = json['isCompetitive'] as bool?;
    skillRequired = json['skillRequired'] as num?;
    if (json['team1'] != null) {
      team1 = <DataTeam1>[];
      json['team1'].forEach((v) {
        team1!.add(DataTeam1.fromJson(v));
      });
    }
    if (json['team2'] != null) {
      team2 = <DataTeam1>[];
      json['team2'].forEach((v) {
        team2!.add(DataTeam1.fromJson(v));
      });
    }
    venue = json['venue'] != null ? Venue.fromJson(json['venue']) : null;
    court = json['court'] != null ? Court.fromJson(json['court']) : null;
    distance = (json['distance'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['bookingDate'] = bookingDate;
    data['formattedDate'] = formattedDate;
    data['bookingSlots'] = bookingSlots;
    data['askToJoin'] = askToJoin;
    data['isCompetitive'] = isCompetitive;
    data['skillRequired'] = skillRequired;
    if (team1 != null) {
      data['team1'] = team1!.map((v) => v.toJson()).toList();
    }
    if (team2 != null) {
      data['team2'] = team2!.map((v) => v.toJson()).toList();
    }
    if (venue != null) {
      data['venue'] = venue!.toJson();
    }
    if (court != null) {
      data['court'] = court!.toJson();
    }
    data['distance'] = distance;
    return data;
  }
}

class DataTeam1 {
  String? playerType;
  Players? player;

  DataTeam1({this.playerType, this.player});

  DataTeam1.fromJson(Map<String, dynamic> json) {
    playerType = json['playerType'] as String?;
    player = json['player'] != null ? Players.fromJson(json['player']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['playerType'] = playerType;
    if (player != null) {
      data['player'] = player!.toJson();
    }
    return data;
  }
}

class Players {
  String? sId;
  String? name;
  String? image;

  Players({this.sId, this.name, this.image});

  Players.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] as String?;
    name = json['name'] as String?;
    image = json['image'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class Venue {
  String? sId;
  String? name;
  String? address;
  String? city;
  String? state;
  String? image;
  // Weather? weather;

  Venue({this.sId, this.name, this.address, this.city, this.state, this.image, });

  Venue.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] as String?;
    name = json['name'] as String?;
    address = json['address'] as String?;
    city = json['city'] as String?;
    state = json['state'] as String?;
    image = json['image'] as String?;
    // weather = json['weather'] != null ? Weather.fromJson(json['weather']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['image'] = image;
    // if (weather != null) {
    //   data['weather'] = weather!.toJson();
    // }
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
    status = json['status'] as String?;
    icon = json['icon'] as String?;
    temperature = (json['temperature'] as num?)?.toDouble();
    lastUpdated = json['lastUpdated'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['icon'] = icon;
    data['temperature'] = temperature;
    data['lastUpdated'] = lastUpdated;
    return data;
  }
}

class Court {
  String? sId;
  String? name;
  String? venueId;
  String? games;
  num? hourlyRate;
  String? image;

  Court({this.sId, this.name, this.venueId, this.games, this.hourlyRate, this.image});

  Court.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] as String?;
    name = json['name'] as String?;
    venueId = json['venueId'] as String?;
    games = json['games'] as String?;
    hourlyRate = json['hourlyRate'] as num?;
    image = json['image'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['venueId'] = venueId;
    data['games'] = games;
    data['hourlyRate'] = hourlyRate;
    data['image'] = image;
    return data;
  }
}

class Meta {
  int? totalMatches;
  bool? isSpecificDate;
  String? date;
  bool? isToday;

  Meta({this.totalMatches, this.isSpecificDate, this.date, this.isToday});

  Meta.fromJson(Map<String, dynamic> json) {
    totalMatches = json['totalMatches'] as int?;
    isSpecificDate = json['isSpecificDate'] as bool?;
    date = json['date'] as String?;
    isToday = json['isToday'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalMatches'] = totalMatches;
    data['isSpecificDate'] = isSpecificDate;
    data['date'] = date;
    data['isToday'] = isToday;
    return data;
  }
}