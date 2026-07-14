
import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/update_otp_model.dart';

import 'package:maxpay/core/error/failure.dart';

abstract class UpdateOtpRepository {
  Future<Either<Failure, UpdateOtp>> updateotp({
    required String otp,
    });

  }
