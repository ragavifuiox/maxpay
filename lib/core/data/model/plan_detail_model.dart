// class PlanDetail {
//   bool? success;
//   List<PlanDetailData>? data;
//   String? message;
//   int? code;

//   PlanDetail({this.success, this.data, this.message, this.code});

//   PlanDetail.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     if (json['data'] != null) {
//       data = <PlanDetailData>[];
//       json['data'].forEach((v) {
//         data!.add(new PlanDetailData.fromJson(v));
//       });
//     }
//     message = json['message'];
//     code = json['code'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['message'] = this.message;
//     data['code'] = this.code;
//     return data;
//   }
// }

// class PlanDetailData {
//   int? id;
//   Null? category;
//   String? name;
//   String? productCode;
//   String? customerCare;
//   String? adminCommission;
//   String? commissionType;
//   String? logo;
//   String? msgToNumber;
//   Null? messageToNumber;
//   String? minRechargeAmount;
//   String? maxRechargeAmount;
//   String? customerBlockAmount;
//   String? apiBlockAmount;
//   String? specialCustomerBlockAmount;
//   String? digitsAllowed;
//   String? startingDigits;
//   String? inactiveMessage;
//   String? description;
//   String? apiName;
//   String? amountToBlock;
//   int? isActive;
//   String? needLiveMenu;
//   String? productLimit;
//   String? productType;
//   String? productTypeId;
//   int? isEnable;
//   String? createdAt;
//   String? updatedAt;

//   PlanDetailData(
//       {this.id,
//       this.category,
//       this.name,
//       this.productCode,
//       this.customerCare,
//       this.adminCommission,
//       this.commissionType,
//       this.logo,
//       this.msgToNumber,
//       this.messageToNumber,
//       this.minRechargeAmount,
//       this.maxRechargeAmount,
//       this.customerBlockAmount,
//       this.apiBlockAmount,
//       this.specialCustomerBlockAmount,
//       this.digitsAllowed,
//       this.startingDigits,
//       this.inactiveMessage,
//       this.description,
//       this.apiName,
//       this.amountToBlock,
//       this.isActive,
//       this.needLiveMenu,
//       this.productLimit,
//       this.productType,
//       this.productTypeId,
//       this.isEnable,
//       this.createdAt,
//       this.updatedAt});

//   PlanDetailData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     category = json['category'];
//     name = json['name'];
//     productCode = json['product_code'];
//     customerCare = json['customer_care'];
//     adminCommission = json['admin_commission'];
//     commissionType = json['commission_type'];
//     logo = json['logo'];
//     msgToNumber = json['msg_to_number'];
//     messageToNumber = json['message_to_number'];
//     minRechargeAmount = json['min_recharge_amount'];
//     maxRechargeAmount = json['max_recharge_amount'];
//     customerBlockAmount = json['customer_block_amount'];
//     apiBlockAmount = json['api_block_amount'];
//     specialCustomerBlockAmount = json['special_customer_block_amount'];
//     digitsAllowed = json['digits_allowed'];
//     startingDigits = json['starting_digits'];
//     inactiveMessage = json['inactive_message'];
//     description = json['description'];
//     apiName = json['api_name'];
//     amountToBlock = json['amount_to_block'];
//     isActive = json['is_active'];
//     needLiveMenu = json['need_live_menu'];
//     productLimit = json['product_limit'];
//     productType = json['product_type'];
//     productTypeId = json['product_type_id'];
//     isEnable = json['is_enable'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['category'] = this.category;
//     data['name'] = this.name;
//     data['product_code'] = this.productCode;
//     data['customer_care'] = this.customerCare;
//     data['admin_commission'] = this.adminCommission;
//     data['commission_type'] = this.commissionType;
//     data['logo'] = this.logo;
//     data['msg_to_number'] = this.msgToNumber;
//     data['message_to_number'] = this.messageToNumber;
//     data['min_recharge_amount'] = this.minRechargeAmount;
//     data['max_recharge_amount'] = this.maxRechargeAmount;
//     data['customer_block_amount'] = this.customerBlockAmount;
//     data['api_block_amount'] = this.apiBlockAmount;
//     data['special_customer_block_amount'] = this.specialCustomerBlockAmount;
//     data['digits_allowed'] = this.digitsAllowed;
//     data['starting_digits'] = this.startingDigits;
//     data['inactive_message'] = this.inactiveMessage;
//     data['description'] = this.description;
//     data['api_name'] = this.apiName;
//     data['amount_to_block'] = this.amountToBlock;
//     data['is_active'] = this.isActive;
//     data['need_live_menu'] = this.needLiveMenu;
//     data['product_limit'] = this.productLimit;
//     data['product_type'] = this.productType;
//     data['product_type_id'] = this.productTypeId;
//     data['is_enable'] = this.isEnable;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }




class PlanDetail {
  bool? success;
  List<PlanDetailData>? data;
  String? message;
  int? code;

  PlanDetail({this.success, this.data, this.message, this.code});

  PlanDetail.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <PlanDetailData>[];
      json['data'].forEach((v) {
        data!.add(PlanDetailData.fromJson(v));
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

class PlanDetailData {
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

  PlanDetailData(
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

  PlanDetailData.fromJson(Map<String, dynamic> json) {
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
