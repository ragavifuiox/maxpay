class Statement {
  bool? success;
  List<StatementData>? data;
  String? message;
  int? code;

  Statement({this.success, this.data, this.message, this.code});

  Statement.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <StatementData>[];
      json['data'].forEach((v) {
        data!.add(new StatementData.fromJson(v));
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

class StatementData {
  int? id;
  String? transactionId;
  String? description;
  String? dateTime;
  String? openingBalance;
  String? credit;
  String? debit;
  String? closingBalance;

  StatementData(
      {this.id,
      this.transactionId,
      this.description,
      this.dateTime,
      this.openingBalance,
      this.credit,
      this.debit,
      this.closingBalance});

  StatementData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    description = json['description'];
    dateTime = json['date_time'];
    openingBalance = json['opening_balance'];
    credit = json['credit'];
    debit = json['debit'];
    closingBalance = json['closing_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_id'] = this.transactionId;
    data['description'] = this.description;
    data['date_time'] = this.dateTime;
    data['opening_balance'] = this.openingBalance;
    data['credit'] = this.credit;
    data['debit'] = this.debit;
    data['closing_balance'] = this.closingBalance;
    return data;
  }
}
