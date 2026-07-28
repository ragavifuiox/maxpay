import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/update_pin_model.dart';
import 'package:maxpay/core/data/model/update_profile_otp_model.dart';

import 'package:maxpay/core/error/failure.dart';

abstract class UpdateProfileOtpRepository {
  Future<Either<Failure, UpdateprofileOtp>> updateotp({
  required String otp,
  required String mobile,

});

  }
