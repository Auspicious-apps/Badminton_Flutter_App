class AuthRequestModel {


  static Map<String, dynamic> updateProfile({
    String? firstName,
    String? lastName,

    String? password,
    String? oldPassword,
    String? profilePic,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (firstName != null && firstName.isNotEmpty) data["firstName"] = firstName;
    if (lastName != null && lastName.isNotEmpty) data["lastName"] = lastName;
    if (oldPassword != null && oldPassword.isNotEmpty) data["oldPassword"] = oldPassword;
    if (password != null && password.isNotEmpty) data["password"] = password;
    if (profilePic != null && profilePic.isNotEmpty) data["profilePic"] = profilePic;

    return data;
  }


  static signupRequestModel({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String countryCode,
    required String password,
    required String dob,
    required String referralUsed,

    required List<num> coordinates,
    required String fcmToken,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data["email"] = email;
    data["phoneNumber"] = phoneNumber;
    data["countryCode"] = countryCode;
    data["password"] = password;
    data["dob"] = dob;
    data["location"] = {
      "type": "Point",
      "coordinates": coordinates,
    };
    data["fcmToken"] = fcmToken;
    data["referralUsed"] = referralUsed;
    return data;
  }

  static logout({

    required String fcmToken,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};


    data["fcmToken"] = fcmToken;

    return data;
  }


  static MessageRequest({
     String? chatId,
     String? content,
    String? recipientId,


  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["chatId"] = chatId;
    data["content"] = content;
    data["recipientId"] = recipientId;


    return data;
  }


  static emailVerificationRequest({
    required String emailOtp,

  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["emailOtp"] = emailOtp;


    return data;
  }



  static AddToCartRequest({
    required String id,

  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;


    return data;
  }

  static forgetVerificationRequest({
    required String otp,

  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["otp"] = otp;


    return data;
  }

  static phoneVerificationRequest({

    required String phoneOtp,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["phoneOtp"] = phoneOtp;

    return data;
  }


  static acceptRequestModel({
    required String requestId,
    required String status,

  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["requestId"] = requestId;
    data["status"] = status;

    return data;
  }


  static blockRequestModel({
    required String userId,

  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["userId"] = userId;


    return data;
  }


  static resendOtpApiRequest({
     String? email,
     String? phoneNumber,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data["phoneNumber"] = phoneNumber;

    return data;
  }


  static loginApiRequest({
    String? email,
    String? password,
    String? authType,
    String? fcmToken,

  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data["password"] = password;
    data["authType"] = authType;
    data["fcmToken"] = fcmToken;

    return data;
  }


  static socialloginApiRequest({
    required String authType,
    required String idToken,
    required String fcmToken,
    Map<String, dynamic>? location,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authType'] = authType;
    data['idToken'] = idToken;
    data['fcmToken'] = fcmToken;

    if (location != null) {
      data['location'] = location;
    }
    return data;
  }


  static resetPassword({
    String? password,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["password"] = password;
    return data;
  }


  static sendFriendRequest({
    String? friendId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["friendId"] = friendId;
    return data;
  }

}
