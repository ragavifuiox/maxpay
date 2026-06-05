class PlanTab {
  bool? success;
  List<PlantabData>? data;
  String? message;
  int? code;

  PlanTab({this.success, this.data, this.message, this.code});

  PlanTab.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <PlantabData>[];
      json['data'].forEach((v) {
        data!.add(new PlantabData.fromJson(v));
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

class PlantabData {
  int? id;
  String? planType;
  String? planTypePriority;
  String? talkTime;

  PlantabData({this.id, this.planType, this.planTypePriority, this.talkTime});

  PlantabData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planType = json['plan_type'];
    planTypePriority = json['plan_type_priority'];
    talkTime = json['talk_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plan_type'] = this.planType;
    data['plan_type_priority'] = this.planTypePriority;
    data['talk_time'] = this.talkTime;
    return data;
  }
}
