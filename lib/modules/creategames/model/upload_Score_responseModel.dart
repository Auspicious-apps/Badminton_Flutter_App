class UploadScoreResponseModel {
  bool? success;
  String? message;
  Data? data;

  UploadScoreResponseModel({this.success, this.message, this.data});

  UploadScoreResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String? sId;
  String? bookingId;
  Set1? set1;
  Set1? set2;
  Set1? set3;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
        this.bookingId,
        this.set1,
        this.set2,
        this.set3,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
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
  int? team1;
  int? team2;

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