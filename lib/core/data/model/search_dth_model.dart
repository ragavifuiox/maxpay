class SearchDth {
  bool? success;
  List<SearchDthData>? data;
  String? message;
  int? code;

  SearchDth({this.success, this.data, this.message, this.code});

  SearchDth.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SearchDthData>[];
      json['data'].forEach((v) {
        data!.add(new SearchDthData.fromJson(v));
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

class SearchDthData {
  int? id;
  int? productId;
  String? productName;
  int? plantypeId;
  String? planType;
  String? planName;
  String? oneMonth;
  String? threeMonth;
  String? sixMonth;
  String? twelveMonth;
  String? planDetails;
  String? createdAt;
  String? updatedAt;

  SearchDthData(
      {this.id,
      this.productId,
      this.productName,
      this.plantypeId,
      this.planType,
      this.planName,
      this.oneMonth,
      this.threeMonth,
      this.sixMonth,
      this.twelveMonth,
      this.planDetails,
      this.createdAt,
      this.updatedAt});

  SearchDthData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    plantypeId = json['plantype_id'];
    planType = json['plan_type'];
    planName = json['plan_name'];
    oneMonth = json['one_month'];
    threeMonth = json['three_month'];
    sixMonth = json['six_month'];
    twelveMonth = json['twelve_month'];
    planDetails = json['plan_details'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['plantype_id'] = this.plantypeId;
    data['plan_type'] = this.planType;
    data['plan_name'] = this.planName;
    data['one_month'] = this.oneMonth;
    data['three_month'] = this.threeMonth;
    data['six_month'] = this.sixMonth;
    data['twelve_month'] = this.twelveMonth;
    data['plan_details'] = this.planDetails;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
