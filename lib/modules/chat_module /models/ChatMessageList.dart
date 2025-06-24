class ChatMessagesList {
  bool? success;
  String? message;
  MessageData? data;
  String? myId;

  ChatMessagesList({this.success, this.message, this.data, this.myId});

  ChatMessagesList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new MessageData.fromJson(json['data']) : null;
    myId = json['myId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['myId'] = this.myId;
    return data;
  }
}

class MessageData {
  LastMessage? lastMessage;
  String? sId;
  String? chatType;
  List<Participant>? participants;
  List<Messages>? messages;
  String? groupName;
  String? bookingId;
  List<String>? groupAdmin;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;

  MessageData(
  {this.lastMessage,
        this.sId,
        this.chatType,
        this.participants,
        this.messages,
        this.groupName,
        this.bookingId,
        this.groupAdmin,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.iV});

  MessageData.fromJson(Map<String, dynamic> json) {
    lastMessage = json['lastMessage'] != null
        ? new LastMessage.fromJson(json['lastMessage'])
        : null;
    sId = json['_id'];
    chatType = json['chatType'];
    if (json['participants'] != null) {
      participants = <Participant>[];
      json['participants'].forEach((v) {
        participants!.add(new Participant.fromJson(v));
      });
    }
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
    groupName = json['groupName'];
    bookingId = json['bookingId'];
    groupAdmin = json['groupAdmin'].cast<String>();
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lastMessage != null) {
      data['lastMessage'] = this.lastMessage!.toJson();
    }
    data['_id'] = this.sId;
    data['chatType'] = this.chatType;
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    data['groupName'] = this.groupName;
    data['bookingId'] = this.bookingId;
    data['groupAdmin'] = this.groupAdmin;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class LastMessage {
  String? content;
  String? sender;
  String? timestamp;
  String? contentType;

  LastMessage({this.content, this.sender, this.timestamp, this.contentType});

  LastMessage.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    sender = json['sender'];
    timestamp = json['timestamp'];
    contentType = json['contentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['sender'] = this.sender;
    data['timestamp'] = this.timestamp;
    data['contentType'] = this.contentType;
    return data;
  }
}

class Participant {
  String? sId;
  String? fullName;
  String? email;
  String? profilePic;

  Participant({this.sId, this.fullName, this.email, this.profilePic});

  Participant.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    profilePic = json['profilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['profilePic'] = this.profilePic;
    return data;
  }
}

class Messages {
  Participant? sender;
  String? content;
  String? contentType;
  List<ReadBy>? readBy;
  String? sId;
  String? createdAt;
  String? updatedAt;

  Messages(
      {this.sender,
        this.content,
        this.contentType,
        this.readBy,
        this.sId,
        this.createdAt,
        this.updatedAt});

  Messages.fromJson(Map<String, dynamic> json) {
    sender = json['sender'] != null
        ? new Participant.fromJson(json['sender'])
        : null;
    content = json['content'];
    contentType = json['contentType'];
    if (json['readBy'] != null) {
      readBy = <ReadBy>[];
      json['readBy'].forEach((v) {
        readBy!.add(new ReadBy.fromJson(v));
      });
    }
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    data['content'] = this.content;
    data['contentType'] = this.contentType;
    if (this.readBy != null) {
      data['readBy'] = this.readBy!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class ReadBy {
  String? sId;
  String? email;
  String? fullName;
  String? role;
  String? authType;
  String? countryCode;
  String? phoneNumber;
  String? profilePic;
  bool? emailVerified;
  bool? phoneVerified;
  Otp? otp;
  String? language;


  String? country;
  Location? location;
  bool? isBlocked;

  ReadBy(
      {this.sId,
        this.email,
        this.fullName,
        this.role,
        this.authType,
        this.countryCode,
        this.phoneNumber,
        this.profilePic,
        this.emailVerified,
        this.phoneVerified,
        this.otp,
        this.language,

        this.country,
        this.location,
        this.isBlocked});

  ReadBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    fullName = json['fullName'];
    role = json['role'];
    authType = json['authType'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    profilePic = json['profilePic'];
    emailVerified = json['emailVerified'];
    phoneVerified = json['phoneVerified'];
    otp = json['otp'] != null ? new Otp.fromJson(json['otp']) : null;
    language = json['language'];

    country = json['country'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    isBlocked = json['isBlocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['role'] = this.role;
    data['authType'] = this.authType;
    data['countryCode'] = this.countryCode;
    data['phoneNumber'] = this.phoneNumber;
    data['profilePic'] = this.profilePic;
    data['emailVerified'] = this.emailVerified;
    data['phoneVerified'] = this.phoneVerified;
    if (this.otp != null) {
      data['otp'] = this.otp!.toJson();
    }

    data['country'] = this.country;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['isBlocked'] = this.isBlocked;
    return data;
  }
}

class Otp {
  Null? emailCode;
  Null? phoneCode;
  Null? expiresAt;

  Otp({this.emailCode, this.phoneCode, this.expiresAt});

  Otp.fromJson(Map<String, dynamic> json) {
    emailCode = json['emailCode'];
    phoneCode = json['phoneCode'];
    expiresAt = json['expiresAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emailCode'] = this.emailCode;
    data['phoneCode'] = this.phoneCode;
    data['expiresAt'] = this.expiresAt;
    return data;
  }
}

class Location {
  String? type;
  List<num>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<num>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}




