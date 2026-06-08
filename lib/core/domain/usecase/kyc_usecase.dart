import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/kyc_add_response.dart';
import 'package:maxpay/core/domain/repository/kyc_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class AddKycUsecase {
  final KycRepository repository;
  AddKycUsecase(this.repository);
  Future<Either<Failure, KycAddResponse>> call(
    String email,
    File idProof,
    File gstNo,
    File pan,
  ) {
    return repository.addKyc(email, idProof, gstNo, pan);
  }
}
