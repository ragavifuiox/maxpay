class RetailorGrade {
  bool? success;
  Data? data;
  String? message;
  int? code;

  RetailorGrade({this.success, this.data, this.message, this.code});

  RetailorGrade.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  Retailer? retailer;
  double? walletBalance;
  CurrentMonth? currentMonth;
  LastMonth? lastMonth;
  DisplayCard? displayCard;
  List<GradeSlabs>? gradeSlabs;

  Data(
      {this.retailer,
      this.walletBalance,
      this.currentMonth,
      this.lastMonth,
      this.displayCard,
      this.gradeSlabs});

  Data.fromJson(Map<String, dynamic> json) {
  retailer = json['retailer'] != null
      ? Retailer.fromJson(json['retailer'])
      : null;

  walletBalance = (json['wallet_balance'] as num?)?.toDouble();

  currentMonth = json['current_month'] != null
      ? CurrentMonth.fromJson(json['current_month'])
      : null;

  lastMonth = json['last_month'] != null
      ? LastMonth.fromJson(json['last_month'])
      : null;

  displayCard = json['display_card'] != null
      ? DisplayCard.fromJson(json['display_card'])
      : null;

  if (json['grade_slabs'] != null) {
    gradeSlabs = [];
    json['grade_slabs'].forEach((v) {
      gradeSlabs!.add(GradeSlabs.fromJson(v));
    });
  }
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.retailer != null) {
      data['retailer'] = this.retailer!.toJson();
    }
    data['wallet_balance'] = this.walletBalance;
    if (this.currentMonth != null) {
      data['current_month'] = this.currentMonth!.toJson();
    }
    if (this.lastMonth != null) {
      data['last_month'] = this.lastMonth!.toJson();
    }
    if (this.displayCard != null) {
      data['display_card'] = this.displayCard!.toJson();
    }
    if (this.gradeSlabs != null) {
      data['grade_slabs'] = this.gradeSlabs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Retailer {
  String? userId;
  String? retailerName;
  String? mobile;

  Retailer({this.userId, this.retailerName, this.mobile});

  Retailer.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    retailerName = json['retailer_name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['retailer_name'] = this.retailerName;
    data['mobile'] = this.mobile;
    return data;
  }
}

class CurrentMonth {
  String? grade;
  String? monthKey;
  String? monthLabel;
  int? daysTracked;
  double? actualAvg;
  String? label;

  CurrentMonth(
      {this.grade,
      this.monthKey,
      this.monthLabel,
      this.daysTracked,
      this.actualAvg,
      this.label});

  CurrentMonth.fromJson(Map<String, dynamic> json) {
  grade = json['grade'];
  monthKey = json['month_key'];
  monthLabel = json['month_label'];
  daysTracked = json['days_tracked'];

  actualAvg = (json['actual_avg'] as num?)?.toDouble();

  label = json['label'];
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grade'] = this.grade;
    data['month_key'] = this.monthKey;
    data['month_label'] = this.monthLabel;
    data['days_tracked'] = this.daysTracked;
    data['actual_avg'] = this.actualAvg;
    data['label'] = this.label;
    return data;
  }
}

class LastMonth {
  String? grade;
  String? monthKey;
  String? monthLabel;
  int? daysTracked;
 double? actualAvg;
  Null? cashback;
  String? label;

  LastMonth(
      {this.grade,
      this.monthKey,
      this.monthLabel,
      this.daysTracked,
      this.actualAvg,
      this.cashback,
      this.label});

 LastMonth.fromJson(Map<String, dynamic> json) {
  grade = json['grade'];
  monthKey = json['month_key'];
  monthLabel = json['month_label'];
  daysTracked = json['days_tracked'];

  actualAvg = (json['actual_avg'] as num?)?.toDouble();

  cashback = json['cashback'];
  label = json['label'];
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grade'] = this.grade;
    data['month_key'] = this.monthKey;
    data['month_label'] = this.monthLabel;
    data['days_tracked'] = this.daysTracked;
    data['actual_avg'] = this.actualAvg;
    data['cashback'] = this.cashback;
    data['label'] = this.label;
    return data;
  }
}

class DisplayCard {
  String? grade;
  String? label;
  String? monthLabel;
  String? source;

  DisplayCard({this.grade, this.label, this.monthLabel, this.source});

  DisplayCard.fromJson(Map<String, dynamic> json) {
    grade = json['grade'];
    label = json['label'];
    monthLabel = json['month_label'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grade'] = this.grade;
    data['label'] = this.label;
    data['month_label'] = this.monthLabel;
    data['source'] = this.source;
    return data;
  }
}

class GradeSlabs {
  int? sno;
  String? grade;
  int? dailyAverageBalance;
  double? monthlyCashBack;

  GradeSlabs(
      {this.sno, this.grade, this.dailyAverageBalance, this.monthlyCashBack});

 GradeSlabs.fromJson(Map<String, dynamic> json) {
  sno = json['sno'];
  grade = json['grade'];

  dailyAverageBalance = (json['daily_average_balance'] as num?)?.toInt();

  monthlyCashBack = (json['monthly_cash_back'] as num?)?.toDouble();
}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['grade'] = this.grade;
    data['daily_average_balance'] = this.dailyAverageBalance;
    data['monthly_cash_back'] = this.monthlyCashBack;
    return data;
  }
}
