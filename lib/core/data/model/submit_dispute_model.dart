class SubmitDispute {
  bool? success;
  SubmitDisputeData? data;
  String? message;
  int? code;

  SubmitDispute({this.success, this.data, this.message, this.code});

  SubmitDispute.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new SubmitDisputeData.fromJson(json['data']) : null;
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

class SubmitDisputeData {
  int? id;
  String? userId;
  int? rechargeId;
  String? subject;
  String? description;
  String? status;
  Null? adminReply;
  String? createdAt;
  String? updatedAt;

  SubmitDisputeData(
      {this.id,
      this.userId,
      this.rechargeId,
      this.subject,
      this.description,
      this.status,
      this.adminReply,
      this.createdAt,
      this.updatedAt});

  SubmitDisputeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    rechargeId = json['recharge_id'];
    subject = json['subject'];
    description = json['description'];
    status = json['status'];
    adminReply = json['admin_reply'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['recharge_id'] = this.rechargeId;
    data['subject'] = this.subject;
    data['description'] = this.description;
    data['status'] = this.status;
    data['admin_reply'] = this.adminReply;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
