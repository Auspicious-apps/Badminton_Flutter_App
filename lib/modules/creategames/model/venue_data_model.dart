class VenueDataModel {
  bool? success;
  String? message;
  List<VenueData>? data;

  VenueDataModel({this.success, this.message, this.data});

  VenueDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <VenueData>[];
      json['data'].forEach((v) {
        data!.add(new VenueData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VenueData {
  String? sId;
  String? name;
  String? city;
  String? state;
  String? image;
  List<Courts>? courts;
  Weather? weather;
  num? distance;
  String? date;
  String? formattedDate;

  VenueData(
      {this.sId,
        this.name,
        this.city,
        this.state,
        this.image,
        this.courts,
        this.weather,
        this.date,
        this.distance,
        this.formattedDate});

  VenueData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    city = json['city'];
    state = json['state'];
    image = json['image'];
    if (json['courts'] != null) {
      courts = <Courts>[];
      json['courts'].forEach((v) {
        courts!.add(new Courts.fromJson(v));
      });
    }
    weather =
    json['weather'] != null ? new Weather.fromJson(json['weather']) : null;
    date = json['date'];
    distance = json['distance'];
    formattedDate = json['formattedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['city'] = this.city;
    data['state'] = this.state;
    data['image'] = this.image;
    if (this.courts != null) {
      data['courts'] = this.courts!.map((v) => v.toJson()).toList();
    }
    if (this.weather != null) {
      data['weather'] = this.weather!.toJson();
    }
    data['date'] = this.date;
    data['distance'] = this.distance;
    data['formattedDate'] = this.formattedDate;
    return data;
  }
}

class Courts {
  String? name;
  bool? isActive;
  String? games;
  String? sId;
  List<AvailableSlots>? availableSlots;

  Courts({this.name, this.isActive, this.games, this.sId, this.availableSlots});

  Courts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isActive = json['isActive'];
    games = json['games'];
    sId = json['_id'];
    
    if (json['availableSlots'] != null) {
      availableSlots = <AvailableSlots>[];
      json['availableSlots'].forEach((v) {
        if (v is String) {
          // Handle case where availableSlots is a list of strings
          availableSlots!.add(AvailableSlots(time: v));
        } else if (v is Map<String, dynamic>) {
          // Handle case where availableSlots is a list of objects
          availableSlots!.add(AvailableSlots.fromJson(v));
        }
      });
    } else {
      availableSlots = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['isActive'] = this.isActive;
    data['games'] = this.games;
    data['_id'] = this.sId;
    if (this.availableSlots != null) {
      data['availableSlots'] = this.availableSlots!.map((v) => v.time).toList();
    }
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

class AvailableSlots {
  String? time;
  int? price;
  bool? isDiscounted;
  bool? isPremium;
  bool? isAvailable;
  bool? isBooked;
  bool? isPastSlot;

  AvailableSlots({
    this.time,
    this.price,
    this.isDiscounted,
    this.isPremium,
    this.isAvailable,
    this.isBooked,
    this.isPastSlot
  });

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
