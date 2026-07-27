import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/data/model/login_model.dart';
import 'package:maxpay/core/domain/repository/login_repository.dart';

class VerifyPinUseCase {
  final LoginRepository repository;

  VerifyPinUseCase(this.repository);

  Future<Either<Failure, LoginModel>> call(String pin) async {
    return await repository.verifyPin(pin);
  }
}
