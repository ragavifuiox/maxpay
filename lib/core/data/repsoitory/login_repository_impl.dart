import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/data/repsoitory/login_remote_data_source_impl.dart';
import 'package:maxpay/core/data/model/login_model.dart';
import 'package:maxpay/core/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, LoginModel>> sendOtp(String countryCode, String phoneNumber) async {
    try {
      final remoteLogin = await remoteDataSource.sendOtp(countryCode, phoneNumber);
      return Right(remoteLogin);
    } catch (e) {
      if (e.toString().contains('Network Error')) {
        return Left(NetworkFailure(e.toString()));
      }
      return Left(ServerFailure(e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginModel>> verifyOtp(String phoneNumber, String otp) async {
    try {
      final remoteLogin = await remoteDataSource.verifyOtp(phoneNumber, otp);
      return Right(remoteLogin);
    } catch (e) {
      if (e.toString().contains('Network Error')) {
        return Left(NetworkFailure(e.toString()));
      }
      return Left(ServerFailure(e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginModel>> createPin(String pin) async {
    try {
      final remoteLogin = await remoteDataSource.createPin(pin);
      return Right(remoteLogin);
    } catch (e) {
      if (e.toString().contains('Network Error')) {
        return Left(NetworkFailure(e.toString()));
      }
      return Left(ServerFailure(e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginModel>> verifyPin(String pin) async {
    try {
      final remoteLogin = await remoteDataSource.verifyPin(pin);
      return Right(remoteLogin);
    } catch (e) {
      if (e.toString().contains('Network Error')) {
        return Left(NetworkFailure(e.toString()));
      }
      return Left(ServerFailure(e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginModel>> signupSendOtp(String countryCode, String phoneNumber, String name, String pincode) async {
    try {
      final remoteLogin = await remoteDataSource.signupSendOtp(countryCode, phoneNumber, name, pincode);
      return Right(remoteLogin);
    } catch (e) {
      if (e.toString().contains('Network Error')) {
        return Left(NetworkFailure(e.toString()));
      }
      return Left(ServerFailure(e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> logout() async {
    try {
      final response = await remoteDataSource.logout();
      return Right(response);
    } catch (e) {
      if (e.toString().contains('Network Error')) {
        return Left(NetworkFailure(e.toString()));
      }
      return Left(ServerFailure(e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateFingerprint(int status) async {
    try {
      final response = await remoteDataSource.updateFingerprint(status);
      return Right(response);
    } catch (e) {
      if (e.toString().contains('Network Error')) {
        return Left(NetworkFailure(e.toString()));
      }
      return Left(ServerFailure(e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString()));
    }
  }
}


