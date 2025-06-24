class MessageChat {
  bool? success;
  String? message;
  DataMessage? data;

  MessageChat({this.success, this.message, this.data});

  MessageChat.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new DataMessage.fromJson(json['data']) : null;
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

class DataMessage {
  Message? message;
  Chat? chat;

  DataMessage({this.message, this.chat});

  DataMessage.fromJson(Map<String, dynamic> json) {
    message =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
    chat = json['chat'] != null ? new Chat.fromJson(json['chat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    if (this.chat != null) {
      data['chat'] = this.chat!.toJson();
    }
    return data;
  }
}

class Message {
  String? sender;
  String? content;
  String? contentType;
  List<String>? readBy;
  String? sId;
  String? createdAt;
  String? updatedAt;

  Message(
      {this.sender,
        this.content,
        this.contentType,
        this.readBy,
        this.sId,
        this.createdAt,
        this.updatedAt});

  Message.fromJson(Map<String, dynamic> json) {
    sender = json['sender'];
    content = json['content'];
    contentType = json['contentType'];
    readBy = json['readBy'].cast<String>();
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender'] = this.sender;
    data['content'] = this.content;
    data['contentType'] = this.contentType;
    data['readBy'] = this.readBy;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Chat {
  String? sId;
  String? chatType;

  Chat({this.sId, this.chatType});

  Chat.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    chatType = json['chatType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['chatType'] = this.chatType;
    return data;
  }
}