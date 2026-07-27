import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/data/model/login_model.dart';
import 'package:maxpay/core/domain/repository/login_repository.dart';

class VerifyOtpUseCase {
  final LoginRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<Either<Failure, LoginModel>> call(
    String phoneNumber,
    String otp,
  ) async {
    return await repository.verifyOtp(phoneNumber, otp);
  }
}
