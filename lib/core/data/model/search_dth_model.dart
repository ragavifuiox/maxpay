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
        data!.add(SearchDthData.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['plantype_id'] = plantypeId;
    data['plan_type'] = planType;
    data['plan_name'] = planName;
    data['one_month'] = oneMonth;
    data['three_month'] = threeMonth;
    data['six_month'] = sixMonth;
    data['twelve_month'] = twelveMonth;
    data['plan_details'] = planDetails;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
