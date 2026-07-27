import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/data/model/login_model.dart';
import 'package:maxpay/core/domain/repository/login_repository.dart';

class SignupSendOtpUseCase {
  final LoginRepository repository;

  SignupSendOtpUseCase(this.repository);

  Future<Either<Failure, LoginModel>> call(String countryCode, String phoneNumber, String name, String pincode) async {
    return await repository.signupSendOtp(countryCode, phoneNumber, name, pincode);
  }
}
