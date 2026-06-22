class SubmitDispute {
  bool? success;
  SubmitDisputeData? data;
  String? message;
  int? code;

  SubmitDispute({this.success, this.data, this.message, this.code});

  SubmitDispute.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? SubmitDisputeData.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['code'] = code;
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
  Null adminReply;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['recharge_id'] = rechargeId;
    data['subject'] = subject;
    data['description'] = description;
    data['status'] = status;
    data['admin_reply'] = adminReply;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
