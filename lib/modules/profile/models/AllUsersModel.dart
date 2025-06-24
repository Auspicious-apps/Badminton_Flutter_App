class AllUsersModel {
  bool? success;
  String? message;
  List<UsersData>? data;
  Meta? meta;

  AllUsersModel({this.success, this.message, this.data, this.meta});

  AllUsersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UsersData>[];
      json['data'].forEach((v) {
        data!.add(new UsersData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class UsersData {
  String? sId;
  String? fullName;
  String? profilePic;
  String? email;
  bool? isFriend;

  UsersData({this.sId, this.fullName, this.profilePic, this.email, this.isFriend});

  UsersData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    profilePic = json['profilePic'];
    email = json['email'];
    isFriend = json['isFriend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['profilePic'] = this.profilePic;
    data['email'] = this.email;
    data['isFriend'] = this.isFriend;
    return data;
  }
}

class Meta {
  int? total;
  bool? hasPreviousPage;
  bool? hasNextPage;
  int? page;
  int? limit;
  int? totalPages;

  Meta(
      {this.total,
        this.hasPreviousPage,
        this.hasNextPage,
        this.page,
        this.limit,
        this.totalPages});

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['hasPreviousPage'] = this.hasPreviousPage;
    data['hasNextPage'] = this.hasNextPage;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['totalPages'] = this.totalPages;
    return data;
  }
}