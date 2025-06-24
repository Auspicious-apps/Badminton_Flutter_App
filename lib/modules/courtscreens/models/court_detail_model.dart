class GetCourtDetailResponseModel {
  bool? success;
  String? message;
  CourtDetailData? data;

  GetCourtDetailResponseModel({this.success, this.message, this.data});

  GetCourtDetailResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new CourtDetailData.fromJson(json['data']) : null;
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

class CourtDetailData {
  String? sId;
  String? name;
  String? address;
  String? city;
  String? state;
  String? image;
  List<String>? gamesAvailable;
  List<Facilities>? facilities;
  bool? isActive;
  String? venueInfo;
  List<String>? timeslots;
  List<OpeningHours>? openingHours;
  Location? location;
  Weather? weather;
  String? contactInfo;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<Courts>? courts;
  String? date;
  String? formattedDate;
  String? dayType;

  CourtDetailData(
      {this.sId,
        this.name,
        this.address,
        this.city,
        this.state,
        this.image,
        this.gamesAvailable,
        this.facilities,
        this.isActive,
        this.venueInfo,
        this.timeslots,
        this.openingHours,
        this.location,
        this.weather,
        this.contactInfo,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.courts,
        this.date,
        this.formattedDate,
        this.dayType});

  CourtDetailData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    image = json['image'];
    gamesAvailable = json['gamesAvailable'].cast<String>();
    if (json['facilities'] != null) {
      facilities = <Facilities>[];
      json['facilities'].forEach((v) {
        facilities!.add(new Facilities.fromJson(v));
      });
    }
    isActive = json['isActive'];
    venueInfo = json['venueInfo'];
    timeslots = json['timeslots'].cast<String>();
    if (json['openingHours'] != null) {
      openingHours = <OpeningHours>[];
      json['openingHours'].forEach((v) {
        openingHours!.add(new OpeningHours.fromJson(v));
      });
    }
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    weather =
    json['weather'] != null ? new Weather.fromJson(json['weather']) : null;
    contactInfo = json['contactInfo'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['courts'] != null) {
      courts = <Courts>[];
      json['courts'].forEach((v) {
        courts!.add(new Courts.fromJson(v));
      });
    }
    date = json['date'];
    formattedDate = json['formattedDate'];
    dayType = json['dayType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['image'] = this.image;
    data['gamesAvailable'] = this.gamesAvailable;
    if (this.facilities != null) {
      data['facilities'] = this.facilities!.map((v) => v.toJson()).toList();
    }
    data['isActive'] = this.isActive;
    data['venueInfo'] = this.venueInfo;
    data['timeslots'] = this.timeslots;
    if (this.openingHours != null) {
      data['openingHours'] = this.openingHours!.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.weather != null) {
      data['weather'] = this.weather!.toJson();
    }
    data['contactInfo'] = this.contactInfo;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.courts != null) {
      data['courts'] = this.courts!.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    data['formattedDate'] = this.formattedDate;
    data['dayType'] = this.dayType;
    return data;
  }
}

class Facilities {
  String? name;
  bool? isActive;
  String? sId;

  Facilities({this.name, this.isActive, this.sId});

  Facilities.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isActive = json['isActive'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['isActive'] = this.isActive;
    data['_id'] = this.sId;
    return data;
  }
}

class OpeningHours {
  String? day;
  List<String>? hours;
  String? sId;

  OpeningHours({this.day, this.hours, this.sId});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    hours = json['hours'].cast<String>();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['hours'] = this.hours;
    data['_id'] = this.sId;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
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

class Courts {
  String? sId;
  String? name;
  String? venueId;
  String? games;
  int? hourlyRate;
  String? image;
  List<AvailableSlots>? availableSlots;

  Courts(
      {this.sId,
        this.name,
        this.venueId,
        this.games,
        this.hourlyRate,
        this.image,
        this.availableSlots});

  Courts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    venueId = json['venueId'];
    games = json['games'];
    hourlyRate = json['hourlyRate'];
    image = json['image'];
    if (json['availableSlots'] != null) {
      availableSlots = <AvailableSlots>[];
      json['availableSlots'].forEach((v) {
        availableSlots!.add(new AvailableSlots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['venueId'] = this.venueId;
    data['games'] = this.games;
    data['hourlyRate'] = this.hourlyRate;
    data['image'] = this.image;
    if (this.availableSlots != null) {
      data['availableSlots'] =
          this.availableSlots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AvailableSlots {
  String? time;
  int? price;
  bool? isDiscounted;
  bool? isPremium;
  bool? isAvailable;
  bool? isBooked;
  bool? isPastSlot;

  AvailableSlots(
      {this.time,
        this.price,
        this.isDiscounted,
        this.isPremium,
        this.isAvailable,
        this.isBooked,
        this.isPastSlot});

  AvailableSlots.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    price = json['price'];
    isDiscounted = json['isDiscounted'];
    isPremium = json['isPremium'];
    isAvailable = json['isAvailable'];
    isBooked = json['isBooked'];
    isPastSlot = json['isPastSlot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['price'] = this.price;
    data['isDiscounted'] = this.isDiscounted;
    data['isPremium'] = this.isPremium;
    data['isAvailable'] = this.isAvailable;
    data['isBooked'] = this.isBooked;
    data['isPastSlot'] = this.isPastSlot;
    return data;
  }
}