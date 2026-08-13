



import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/terms_model.dart';
import 'package:maxpay/core/data/model/today_credit_model.dart';
import 'package:maxpay/core/domain/repository/terms_repository.dart';
import 'package:maxpay/core/domain/repository/today_credit_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class TermsUsecase {
  final TermsRepository repository;
  TermsUsecase(this.repository);
  Future<Either<Failure, Terms>> call() {
    return repository.terms();
  }
}
