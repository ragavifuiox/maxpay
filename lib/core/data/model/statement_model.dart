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
        data!.add(StatementData.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['transaction_id'] = transactionId;
    data['description'] = description;
    data['date_time'] = dateTime;
    data['opening_balance'] = openingBalance;
    data['credit'] = credit;
    data['debit'] = debit;
    data['closing_balance'] = closingBalance;
    return data;
  }
}
