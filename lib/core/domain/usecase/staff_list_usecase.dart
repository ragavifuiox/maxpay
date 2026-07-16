import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/staff_lsit_model.dart';
import 'package:maxpay/core/data/model/transaction_report_model.dart';
import 'package:maxpay/core/domain/repository/staff_list_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class StaffListUseCase {
  final StaffListRepository repository;
  StaffListUseCase(this.repository);
  Future<Either<Failure, StaffList>> call() {
    return repository.getStaffList();
  }
}

class StaffTrnsTeportListUseCase {
  final StaffListRepository repository;
  StaffTrnsTeportListUseCase(this.repository);
  Future<Either<Failure, TransactionReport>> call(
    String? prdId,
    String? fromDate,
    String? toDate,
    String? search,
    String? status,
  ) {
    return repository.getStaffTransactionReport(
      prdId,
      fromDate,
      toDate,
      search,
      status,
    );
  }
}
