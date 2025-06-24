class BlocklistModel {
  bool? success;
  String? message;
  List<BlocklistData>? data;

  BlocklistModel({this.success, this.message, this.data});

  BlocklistModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BlocklistData>[];
      json['data'].forEach((v) {
        data!.add(new BlocklistData.fromJson(v));
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

class BlocklistData {
  String? relationshipId;
  String? blockedUserId;
  String? status;
  String? profilePic;
  String? fullName;
  String? updatedAt;
  String? sId;
  String? email;

  BlocklistData(
      {this.relationshipId,
        this.blockedUserId,
        this.status,
        this.profilePic,
        this.fullName,
        this.updatedAt,
        this.sId,
        this.email});

  BlocklistData.fromJson(Map<String, dynamic> json) {
    relationshipId = json['relationshipId'];
    blockedUserId = json['blockedUserId'];
    status = json['status'];
    profilePic = json['profilePic'];
    fullName = json['fullName'];
    updatedAt = json['updatedAt'];
    sId = json['_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['relationshipId'] = this.relationshipId;
    data['blockedUserId'] = this.blockedUserId;
    data['status'] = this.status;
    data['profilePic'] = this.profilePic;
    data['fullName'] = this.fullName;
    data['updatedAt'] = this.updatedAt;
    data['_id'] = this.sId;
    data['email'] = this.email;
    return data;
  }
}