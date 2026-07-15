class Faq {
  bool? success;
  List<Data>? data;
  String? message;
  int? code;

  Faq({this.success, this.data, this.message, this.code});

  Faq.fromJson(Map<String, dynamic> json) {
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
  String? businessType;
  String? userType;
  String? liveFromDate;
  String? liveToDate;
  int? commentBox;
  int? replyOne;
  int? replyTwo;
  int? districtId;
  String? image;
  String? createdAt;

  Data(
      {this.id,
      this.title,
      this.businessType,
      this.userType,
      this.liveFromDate,
      this.liveToDate,
      this.commentBox,
      this.replyOne,
      this.replyTwo,
      this.districtId,
      this.image,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    businessType = json['business_type'];
    userType = json['user_type'];
    liveFromDate = json['live_from_date'];
    liveToDate = json['live_to_date'];
    commentBox = json['comment_box'];
    replyOne = json['reply_one'];
    replyTwo = json['reply_two'];
    districtId = json['district_id'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['business_type'] = this.businessType;
    data['user_type'] = this.userType;
    data['live_from_date'] = this.liveFromDate;
    data['live_to_date'] = this.liveToDate;
    data['comment_box'] = this.commentBox;
    data['reply_one'] = this.replyOne;
    data['reply_two'] = this.replyTwo;
    data['district_id'] = this.districtId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}
