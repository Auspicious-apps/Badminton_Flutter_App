class GetRequestsResponseModel {
  bool? success;
  String? message;
  RequestData? data;

  GetRequestsResponseModel({this.success, this.message, this.data});

  GetRequestsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new RequestData.fromJson(json['data']) : null;
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




class RequestData {
  List<Friends>? friends;
  List<Friends>? requests;

  RequestData({this.friends, this.requests});

  RequestData.fromJson(Map<String, dynamic> json) {
    if (json['friends'] != null) {
      friends = <Friends>[];
      json['friends'].forEach((v) {
        friends!.add(new Friends.fromJson(v));
      });
    }
    if (json['requests'] != null) {
      requests = <Friends>[];
      json['requests'].forEach((v) {
        requests!.add(new Friends.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.friends != null) {
      data['friends'] = this.friends!.map((v) => v.toJson()).toList();
    }
    if (this.requests != null) {
      data['requests'] = this.requests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Friends {
  String? relationshipId;
  String? friendId;
  String? status;
  String? updatedAt;
  String? sId;
  String? email;
  String? profilePic;
  String? fullName;

  Friends(
      {this.relationshipId,
        this.friendId,
        this.status,
        this.updatedAt,
        this.sId,
        this.email,
        this.profilePic,
        this.fullName});

  Friends.fromJson(Map<String, dynamic> json) {
    relationshipId = json['relationshipId'];
    friendId = json['friendId'];
    status = json['status'];
    updatedAt = json['updatedAt'];
    sId = json['_id'];
    email = json['email'];
    profilePic = json['profilePic'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['relationshipId'] = this.relationshipId;
    data['friendId'] = this.friendId;
    data['status'] = this.status;
    data['updatedAt'] = this.updatedAt;
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['profilePic'] = this.profilePic;
    data['fullName'] = this.fullName;
    return data;
  }
}

