class userResponseModel {
  bool? success;
  String? message;
  Data? data;

  userResponseModel({this.success, this.message, this.data});

  userResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? role;
  String? fullName;
  String? firstName;
  String? lastName;
  String? email;
  String? authType;
  String? countryCode;
  String? phoneNumber;
  String? profilePic;
  bool? emailVerified;
  bool? phoneVerified;
  String? language;
  List<String>? fcmToken;
  List<String>? productsLanguage;
  String? dob;
  String? country;
  Location? location;
  bool? isBlocked;
  String? createdAt;
  String? updatedAt;
  String? token;
  num? totalMatches;
  num? totalFriends;
  num? playCoins;
  String? loyaltyTier;
  Referrals? referrals;

  Data(
      {this.sId,
        this.role,
        this.fullName,
        this.firstName,
        this.referrals,
        this.lastName,
        this.email,
        this.authType,
        this.countryCode,
        this.phoneNumber,
        this.profilePic,
        this.emailVerified,
        this.phoneVerified,
        this.language,
        this.fcmToken,
        this.productsLanguage,
        this.dob,
        this.country,
        this.location,
        this.isBlocked,
        this.createdAt,
        this.updatedAt,
        this.token,
        this.totalMatches,
        this.totalFriends,
        this.playCoins,
        this.loyaltyTier});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    role = json['role'];
    fullName = json['fullName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    authType = json['authType'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    profilePic = json['profilePic'];
    emailVerified = json['emailVerified'];
    phoneVerified = json['phoneVerified'];
    referrals = json['referrals'] != null
        ? new Referrals.fromJson(json['referrals'])
        : null;
    language = json['language'];
    fcmToken = json['fcmToken'].cast<String>();
    productsLanguage = json['productsLanguage'].cast<String>();
    dob = json['dob'];
    country = json['country'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    isBlocked = json['isBlocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    token = json['token'];
    totalMatches = json['totalMatches'];
    totalFriends = json['totalFriends'];
    playCoins = json['playCoins'];
    loyaltyTier = json['loyaltyTier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['role'] = this.role;
    data['fullName'] = this.fullName;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['authType'] = this.authType;
    data['countryCode'] = this.countryCode;
    data['phoneNumber'] = this.phoneNumber;
    data['profilePic'] = this.profilePic;
    data['emailVerified'] = this.emailVerified;
    data['phoneVerified'] = this.phoneVerified;
    data['language'] = this.language;
    data['fcmToken'] = this.fcmToken;
    data['productsLanguage'] = this.productsLanguage;
    data['dob'] = this.dob;
    data['country'] = this.country;
    if (this.referrals != null) {
      data['referrals'] = this.referrals!.toJson();
    }

    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['isBlocked'] = this.isBlocked;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['token'] = this.token;
    data['totalMatches'] = this.totalMatches;
    data['totalFriends'] = this.totalFriends;
    data['playCoins'] = this.playCoins;
    data['loyaltyTier'] = this.loyaltyTier;
    return data;
  }
}

class Location {
  String? type;
  List<num>? coordinates;

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

class Referrals {
  String? code;
  String? expiryDate;
  num? usageCount;
  num? maxUsage;
  bool? isActive;

  Referrals(
      {this.code,
        this.expiryDate,
        this.usageCount,
        this.maxUsage,
        this.isActive});

  Referrals.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    expiryDate = json['expiryDate'];
    usageCount = json['usageCount'];
    maxUsage = json['maxUsage'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['expiryDate'] = this.expiryDate;
    data['usageCount'] = this.usageCount;
    data['maxUsage'] = this.maxUsage;
    data['isActive'] = this.isActive;
    return data;
  }
}