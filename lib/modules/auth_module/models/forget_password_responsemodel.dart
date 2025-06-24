class ForgetPasswordModel {
  bool? success;
  String? token;
  String? message;

  ForgetPasswordModel({this.success, this.token, this.message});

  ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['token'] = this.token;
    data['message'] = this.message;
    return data;
  }
}
