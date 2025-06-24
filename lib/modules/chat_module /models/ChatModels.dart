class ChatMessages {
  bool? success;
  String? message;
  ChatData? data;

  ChatMessages({this.success, this.message, this.data});

  ChatMessages.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new ChatData.fromJson(json['data']) : null;
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

class ChatData {
  List<Chats>? chats;
  Pagination? pagination;

  ChatData({this.chats, this.pagination});

  ChatData.fromJson(Map<String, dynamic> json) {
    if (json['chats'] != null) {
      chats = <Chats>[];
      json['chats'].forEach((v) {
        chats!.add(new Chats.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chats != null) {
      data['chats'] = this.chats!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Chats {
  LastMessage? lastMessage;
  String? sId;
  String? chatType;
  List<Participants>? participants;
  List<Null>? messages;
  String? groupName;
  String? bookingId;
  List<String>? groupAdmin;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? recipientName;
  String? recipientEmail;
  String? recipientProfilePic;

  Chats(
      {this.lastMessage,
        this.sId,
        this.chatType,
        this.recipientName,
        this.recipientEmail,
        this.recipientProfilePic,
        this.participants,
        this.messages,
        this.groupName,
        this.bookingId,
        this.groupAdmin,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Chats.fromJson(Map<String, dynamic> json) {
    lastMessage = json['lastMessage'] != null
        ? new LastMessage.fromJson(json['lastMessage'])
        : null;
    sId = json['_id'];
    chatType = json['chatType'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(new Participants.fromJson(v));
      });
    }
    // if (json['messages'] != null) {
    //   messages = <Null>[];
    //   json['messages'].forEach((v) {
    //     messages!.add(new Null.fromJson(v));
    //   });
    // }
    groupName = json['groupName'];
    bookingId = json['bookingId'];
    groupAdmin = json['groupAdmin'].cast<String>();
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    recipientName = json['recipientName'];
    recipientEmail = json['recipientEmail'];
    recipientProfilePic = json['recipientProfilePic'];
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
    // if (this.messages != null) {
    //   data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    // }

    data['recipientName'] = this.recipientName;
    data['recipientEmail'] = this.recipientEmail;
    data['recipientProfilePic'] = this.recipientProfilePic;

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
  String? contentType;
  String? timestamp;
  String? content;


  LastMessage({this.contentType, this.timestamp,this.content});

  LastMessage.fromJson(Map<String, dynamic> json) {
    contentType = json['contentType'];
    timestamp = json['timestamp'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contentType'] = this.contentType;
    data['timestamp'] = this.timestamp;
    data['content'] = this.content;
    return data;
  }
}

class Participants {
  String? sId;
  String? fullName;
  String? email;
  String? profilePic;

  Participants({this.sId, this.fullName, this.email, this.profilePic});

  Participants.fromJson(Map<String, dynamic> json) {
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

class Pagination {
  int? total;
  int? page;
  int? limit;
  int? pages;

  Pagination({this.total, this.page, this.limit, this.pages});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['pages'] = this.pages;
    return data;
  }
}