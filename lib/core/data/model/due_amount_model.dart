
class DueAmount {
  bool? success;
  Code? data;
  String? message;
  int? code;

  DueAmount({this.success, this.data, this.message, this.code});

  factory DueAmount.fromJson(Map<String, dynamic> json) => DueAmount(
    success: json["success"],
    data: json["data"] == null ? null : Code.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
    "code": code,
  };
}

class Code {
  int? pendingAmount;

  Code({this.pendingAmount});

  factory Code.fromJson(Map<String, dynamic> json) =>
      Code(pendingAmount: json["pending_amount"]);

  Map<String, dynamic> toJson() => {"pending_amount": pendingAmount};
}
