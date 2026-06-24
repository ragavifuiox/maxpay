import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/statement_model.dart';
import 'package:maxpay/core/domain/repository/statement_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class StatementUsecase {
  final StatementRepository repository;
  StatementUsecase(this.repository);
  Future<Either<Failure, Statement>> call({
    required String type,
    required String fromdate,
    required String todate,
    required String search,
  }) {
    return repository.statement(
      type: type,

      fromdate: fromdate,
      todate: todate,

      search: search,
    );
  }
}
