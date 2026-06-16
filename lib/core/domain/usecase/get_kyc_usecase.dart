import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/get_kyc_model.dart';

import 'package:maxpay/core/domain/repository/get_kyc_repository.dart';

import 'package:maxpay/core/error/failure.dart';



class GetKycUsecase {
  final GetKycRepository repository;
  GetKycUsecase(this.repository);
  Future<Either<Failure,GetKyc>> call() {
    return repository.getkyc();
  }
}
