import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/get_bank_model.dart';

import 'package:maxpay/core/domain/repository/get_bank_repository.dart';

import 'package:maxpay/core/error/failure.dart';



class GetBankUseCase {
  final GetBankRepository repository;
  GetBankUseCase(this.repository);
  Future<Either<Failure, Bank>> call() {
    return repository.getbank();
  }
}
