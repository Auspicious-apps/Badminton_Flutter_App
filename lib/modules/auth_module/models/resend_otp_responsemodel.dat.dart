class ResendOtpResponse {
  bool? success;
  ResendData? data;

  ResendOtpResponse({this.success, this.data});

  ResendOtpResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new ResendData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ResendData {
  Response? response;

  ResendData({this.response});

  ResendData.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  bool? success;
  String? message;
  List<String>? otp;

  Response({this.success, this.message, this.otp});

  Response.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    otp = json['otp'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['otp'] = this.otp;
    return data;
  }
}