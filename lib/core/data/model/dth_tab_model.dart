class DthTab {
  bool? success;
  List<DthtabData>? data;
  String? message;
  int? code;

  DthTab({this.success, this.data, this.message, this.code});

  DthTab.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DthtabData>[];
      json['data'].forEach((v) {
        data!.add(new DthtabData.fromJson(v));
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

class DthtabData {
  int? id;
  String? planType;
  int? planTypePriority;

  DthtabData({this.id, this.planType, this.planTypePriority});

  DthtabData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planType = json['plan_type'];
    planTypePriority = json['plan_type_priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plan_type'] = this.planType;
    data['plan_type_priority'] = this.planTypePriority;
    return data;
  }
}
