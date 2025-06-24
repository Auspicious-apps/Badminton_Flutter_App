class NotificationResponse {
  bool? success;
  String? message;
  List<NotficationItem>? data;


  NotificationResponse({this.success, this.message, this.data});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NotficationItem>[];
      json['data'].forEach((v) {
        data!.add(new NotficationItem.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class NotficationItem {
  String? sId;
  String? recipientId;
  String? type;
  String? title;
  String? message;
  String? notificationType;
  String? category;
  String? priority;
  String? referenceId;
  String? referenceType;

  bool? isRead;
  bool? isReadyByAdmin;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NotficationItem(
      {this.sId,
        this.recipientId,
        this.type,
        this.title,
        this.message,
        this.notificationType,
        this.category,
        this.priority,
        this.referenceId,
        this.referenceType,

        this.isRead,
        this.isReadyByAdmin,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.iV});

  NotficationItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    recipientId = json['recipientId'];
    type = json['type'];
    title = json['title'];
    message = json['message'];
    notificationType = json['notificationType'];
    category = json['category'];
    priority = json['priority'];
    referenceId = json['referenceId'];
    referenceType = json['referenceType'];

    isRead = json['isRead'];
    isReadyByAdmin = json['isReadyByAdmin'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['recipientId'] = this.recipientId;
    data['type'] = this.type;
    data['title'] = this.title;
    data['message'] = this.message;
    data['notificationType'] = this.notificationType;
    data['category'] = this.category;
    data['priority'] = this.priority;
    data['referenceId'] = this.referenceId;
    data['referenceType'] = this.referenceType;

    data['isRead'] = this.isRead;
    data['isReadyByAdmin'] = this.isReadyByAdmin;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}





