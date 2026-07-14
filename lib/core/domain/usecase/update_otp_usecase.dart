

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/update_otp_model.dart';
import 'package:maxpay/core/domain/repository/update_otp_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class UpdateOtpUsecase {
  final UpdateOtpRepository repository;
  UpdateOtpUsecase(this.repository);
  Future<Either<Failure, UpdateOtp>> call(
    String otp ,
    
  ) {
    return repository.updateotp(
     otp: otp,
    );
  }
}
