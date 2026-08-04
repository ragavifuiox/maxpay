import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/transaction_report_model.dart';
import 'package:maxpay/core/domain/repository/trans_report_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class TransReportUsecase {
  final TransReportRepository repository;
  TransReportUsecase(this.repository);
  Future<Either<Failure, TransactionReportModel>> call({
    required String productid,
    required String fromdate,
    required String todate,
    required String search,
    required String status,
  }) {
    return repository.transreport(
      productid: productid,

      fromdate: fromdate,
      todate: todate,
      status: status,
      search: search,
    );
  }
}
