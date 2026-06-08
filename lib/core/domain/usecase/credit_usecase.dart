import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/gredit_model.dart';
import 'package:maxpay/core/domain/repository/credit_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class GetCreditUseCase {
  final CreditRepository repository;
  GetCreditUseCase(this.repository);
  Future<Either<Failure, Credit>> call() {
    return repository.getCredit();
  }
}
