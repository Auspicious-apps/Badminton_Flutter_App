class PackagesResponseModel {
  bool? success;
  String? message;
  List<PackageData>? data;

  PackagesResponseModel({this.success, this.message, this.data});

  PackagesResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PackageData>[];
      json['data'].forEach((v) {
        data!.add(new PackageData.fromJson(v));
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

class PackageData {
  String? sId;
  num? amount;
  num? coinReceivable;
  num? extraCoins;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  num? iV;

  PackageData(
      {this.sId,
        this.amount,
        this.coinReceivable,
        this.extraCoins,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.iV});

  PackageData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    amount = json['amount'];
    coinReceivable = json['coinReceivable'];
    extraCoins = json['extraCoins'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['amount'] = this.amount;
    data['coinReceivable'] = this.coinReceivable;
    data['extraCoins'] = this.extraCoins;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}