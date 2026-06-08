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
        data!.add(PlantabData.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plan_type'] = planType;
    data['plan_type_priority'] = planTypePriority;
    data['talk_time'] = talkTime;
    return data;
  }
}
