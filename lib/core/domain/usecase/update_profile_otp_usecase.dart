

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/update_profile_otp_model.dart';
import 'package:maxpay/core/domain/repository/update_profile_otp_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class UpdateProfileOtpUsecase {
  final UpdateProfileOtpRepository repository;
  UpdateProfileOtpUsecase(this.repository);
  Future<Either<Failure, UpdateprofileOtp>> call(
    String otp ,
    String mobile ,
  
  ) {
    return repository.updateotp(
     otp: otp,
     mobile: mobile,
   
    );
  }
}
