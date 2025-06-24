class ContentResponseModel {
  bool? success;
  String? message;
  ContentData? data;

  ContentResponseModel({this.success, this.message, this.data});

  ContentResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new ContentData.fromJson(json['data']) : null;
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

class ContentData {
  String? privacyPolicy;
  String? termsAndConditions;

  ContentData({this.privacyPolicy, this.termsAndConditions});

  ContentData.fromJson(Map<String, dynamic> json) {
    privacyPolicy = json['privacyPolicy'];
    termsAndConditions = json['termsAndConditions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['privacyPolicy'] = this.privacyPolicy;
    data['termsAndConditions'] = this.termsAndConditions;
    return data;
  }
}