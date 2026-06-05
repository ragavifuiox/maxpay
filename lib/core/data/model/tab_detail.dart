class TabDetail {
  bool? success;
  List<TabDetailData>? data;
  String? message;
  int? code;

  TabDetail({this.success, this.data, this.message, this.code});

  TabDetail.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <TabDetailData>[];
      json['data'].forEach((v) {
        data!.add(new TabDetailData.fromJson(v));
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

class TabDetailData {
  int? id;
  int? planId;
  int? productId;
  String? productName;
  String? amount;
  int? validity;
  int? talkTime;
  String? planDetails;

  TabDetailData(
      {this.id,
      this.planId,
      this.productId,
      this.productName,
      this.amount,
      this.validity,
      this.talkTime,
      this.planDetails});

  TabDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planId = json['plan_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    amount = json['amount'];
    validity = json['validity'];
    talkTime = json['talk_time'];
    planDetails = json['plan_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plan_id'] = this.planId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['amount'] = this.amount;
    data['validity'] = this.validity;
    data['talk_time'] = this.talkTime;
    data['plan_details'] = this.planDetails;
    return data;
  }
}
