class FaqReply {
  bool? success;
  Data? data;
  String? message;
  int? code;

  FaqReply({this.success, this.data, this.message, this.code});

  FaqReply.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

class Data {
  String? userId;
  String? faqId;
  String? comment;
  String? reply;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.userId,
      this.faqId,
      this.comment,
      this.reply,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    faqId = json['faq_id'];
    comment = json['comment'];
    reply = json['reply'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['faq_id'] = this.faqId;
    data['comment'] = this.comment;
    data['reply'] = this.reply;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
