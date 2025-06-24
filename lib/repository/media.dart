class MediaUploadResponseModel {
  bool? success;
  String? message;
  UploadData? data;

  MediaUploadResponseModel({this.success, this.message, this.data});

  MediaUploadResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new UploadData.fromJson(json['data']) : null;
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

class UploadData {
  String? imageKey;

  UploadData({this.imageKey});

  UploadData.fromJson(Map<String, dynamic> json) {
    imageKey = json['imageKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageKey'] = this.imageKey;
    return data;
  }
}