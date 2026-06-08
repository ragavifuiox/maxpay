

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/finger_print_model.dart';
import 'package:maxpay/core/domain/repository/finger_print_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class FingerPrintUsecase {
  final FingerPrintRepository repository;
  FingerPrintUsecase(this.repository);
  Future<Either<Failure, FingerPrint>> call(
    int fingerprint ,
  ) {
    return repository.fingerprint(
      fingerprint: fingerprint,
    );
  }
}
