import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/earnings_mdoel.dart';
import 'package:maxpay/core/domain/repository/earning_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class GetEarningsUseCase {
  final EarningsRepository repository;
  GetEarningsUseCase(this.repository);
  Future<Either<Failure, Earnings>> call() {
    return repository.getEarnings();
  }
}
