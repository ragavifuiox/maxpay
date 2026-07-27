import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/data/model/login_model.dart';
import 'package:maxpay/core/domain/repository/login_repository.dart';

class CreatePinUseCase {
  final LoginRepository repository;

  CreatePinUseCase(this.repository);

  Future<Either<Failure, LoginModel>> call(String pin) async {
    return await repository.createPin(pin);
  }
}
