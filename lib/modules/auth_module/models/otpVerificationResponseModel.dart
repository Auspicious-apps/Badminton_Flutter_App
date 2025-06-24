class OtpVerification {
  bool? success;
  OtpVerificationData? data;

  OtpVerification({this.success, this.data});

  OtpVerification.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new OtpVerificationData.fromJson(json['data']) : null;
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

class OtpVerificationData {
  Location? location;
  String? sId;
  String? role;
  String? firstName;
  String? lastName;
  String? email;
  String? authType;
  String? countryCode;
  String? phoneNumber;
  Null? profilePic;
  bool? emailVerified;
  bool? phoneVerified;
  String? language;

  List<String>? productsLanguage;
  String? dob;
  String? country;
  bool? isBlocked;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? token;

  OtpVerificationData({
    this.location,
    this.sId,
    this.role,
    this.firstName,
    this.lastName,
    this.email,
    this.authType,
    this.countryCode,
    this.phoneNumber,
    this.profilePic,
    this.emailVerified,
    this.phoneVerified,
    this.language,

    this.productsLanguage,
    this.dob,
    this.country,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.token,
  });

  OtpVerificationData.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    role = json['role'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    authType = json['authType'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    profilePic = json['profilePic'];
    emailVerified = json['emailVerified'];
    phoneVerified = json['phoneVerified'];
    language = json['language'];

    productsLanguage = json['productsLanguage'] != null
        ? List<String>.from(json['productsLanguage'])
        : null;
    dob = json['dob'];
    country = json['country'];
    isBlocked = json['isBlocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (location != null) data['location'] = location!.toJson();
    data['_id'] = sId;
    data['role'] = role;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['authType'] = authType;
    data['countryCode'] = countryCode;
    data['phoneNumber'] = phoneNumber;
    data['profilePic'] = profilePic;
    data['emailVerified'] = emailVerified;
    data['phoneVerified'] = phoneVerified;
    data['language'] = language;

    data['productsLanguage'] = productsLanguage;
    data['dob'] = dob;
    data['country'] = country;
    data['isBlocked'] = isBlocked;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['token'] = token;
    return data;
  }
}




class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}