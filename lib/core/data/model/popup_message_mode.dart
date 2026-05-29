class PopupMessage {
  bool? success;
  List<Data>? data;
  String? message;
  int? code;

  PopupMessage({this.success, this.data, this.message, this.code});

  PopupMessage.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? noOfMsg;
  String? businessType;
  String? userType;
  String? liveFromDate;
  String? liveToDate;
  String? screenType;
  String? message;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.title,
      this.noOfMsg,
      this.businessType,
      this.userType,
      this.liveFromDate,
      this.liveToDate,
      this.screenType,
      this.message,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    noOfMsg = json['no_of_msg'];
    businessType = json['business_type'];
    userType = json['user_type'];
    liveFromDate = json['live_from_date'];
    liveToDate = json['live_to_date'];
    screenType = json['screen_type'];
    message = json['message'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['no_of_msg'] = this.noOfMsg;
    data['business_type'] = this.businessType;
    data['user_type'] = this.userType;
    data['live_from_date'] = this.liveFromDate;
    data['live_to_date'] = this.liveToDate;
    data['screen_type'] = this.screenType;
    data['message'] = this.message;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
