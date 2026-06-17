import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/erify_pin_model.dart';
import 'package:maxpay/core/domain/repository/verify_pin_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class VerifyPinUsecase {
  final VerifyPinRepository repository;
  VerifyPinUsecase(this.repository);
  Future<Either<Failure, VerifyPin>> call(String pin) {
    return repository.Verifypin(pin: pin);
  }
}
