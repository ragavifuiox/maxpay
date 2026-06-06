class SearchPlan {
  bool? success;
  List<PlanData>? data;
  String? message;
  int? code;

  SearchPlan({this.success, this.data, this.message, this.code});

  SearchPlan.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <PlanData>[];
      json['data'].forEach((v) {
        data!.add(PlanData.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}

class PlanData {
  int? id;
  int? planId;
  int? productId;
  String? productName;
  int? talkTime;
  String? amount;
  int? validity;
  String? planDetails;
  String? createdAt;
  String? updatedAt;

PlanData(
      {this.id,
      this.planId,
      this.productId,
      this.productName,
      this.talkTime,
      this.amount,
      this.validity,
      this.planDetails,
      this.createdAt,
      this.updatedAt});

  PlanData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planId = json['plan_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    talkTime = json['talk_time'];
    amount = json['amount'];
    validity = json['validity'];
    planDetails = json['plan_details'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plan_id'] = planId;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['talk_time'] = talkTime;
    data['amount'] = amount;
    data['validity'] = validity;
    data['plan_details'] = planDetails;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
