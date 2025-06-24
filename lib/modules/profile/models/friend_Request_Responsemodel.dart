class FriendRequestResponseModel {
  bool? success;
  String? message;
  FriendData? data;

  FriendRequestResponseModel({this.success, this.message, this.data});

  FriendRequestResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new FriendData.fromJson(json['data']) : null;
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

class FriendData {
  String? userId;
  String? friendId;
  String? status;
  String? sId;
  String? requestedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FriendData(
      {this.userId,
        this.friendId,
        this.status,
        this.sId,
        this.requestedAt,
        this.createdAt,
        this.updatedAt,
        this.iV});

  FriendData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    friendId = json['friendId'];
    status = json['status'];
    sId = json['_id'];
    requestedAt = json['requestedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['friendId'] = this.friendId;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['requestedAt'] = this.requestedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}