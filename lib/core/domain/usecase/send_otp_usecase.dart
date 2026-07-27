import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/data/model/login_model.dart';
import 'package:maxpay/core/domain/repository/login_repository.dart';

class SendOtpUseCase {
  final LoginRepository repository;

  SendOtpUseCase(this.repository);

  Future<Either<Failure, LoginModel>> call(String countryCode, String phoneNumber) async {
    return await repository.sendOtp(countryCode, phoneNumber);
  }
}
