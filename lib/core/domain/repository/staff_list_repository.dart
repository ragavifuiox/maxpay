import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/staff_lsit_model.dart';
import 'package:maxpay/core/data/model/transaction_report_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class StaffListRepository {
  Future<Either<Failure, StaffList>> getStaffList();
  Future<Either<Failure, TransactionReport>> getStaffTransactionReport(
    String? prdId,
    String? fromDate,
    String? toDate,
    String? search,
    String? status,
  );
}
