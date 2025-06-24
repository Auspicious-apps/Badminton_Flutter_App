import 'package:badminton/modules/chat_module%20/models/ChatMessageList.dart';

import '../../chat_module /models/ChatModels.dart';

class IndividualStartChat {
  bool? success;
  String? message;
  IndividualChat? data;

  IndividualStartChat({this.success, this.message, this.data});

  IndividualStartChat.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new IndividualChat.fromJson(json['data']) : null;
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

class IndividualChat {

  String? sId;
  String? chatType;


  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;

  IndividualChat(
      {
        this.sId,
        this.chatType,


        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.iV});

  IndividualChat.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    chatType = json['chatType'];


    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['_id'] = this.sId;
    data['chatType'] = this.chatType;

    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}






