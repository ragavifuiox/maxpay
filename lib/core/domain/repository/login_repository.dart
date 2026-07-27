import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/data/model/login_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginModel>> sendOtp(String countryCode, String phoneNumber);
  Future<Either<Failure, LoginModel>> verifyOtp(String phoneNumber, String otp);
  Future<Either<Failure, LoginModel>> createPin(String pin);
  Future<Either<Failure, LoginModel>> verifyPin(String pin);
  Future<Either<Failure, LoginModel>> signupSendOtp(String countryCode, String phoneNumber, String name, String pincode);
  Future<Either<Failure, Map<String, dynamic>>> logout();
  Future<Either<Failure, Map<String, dynamic>>> updateFingerprint(int status);
}
