import 'package:dartz/dartz.dart';

import 'package:maxpay/core/data/model/login_model.dart';
import 'package:maxpay/core/data/model/otp_response_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class OtpRepository {
  Future<Either<Failure, OtpResponse>> otp({
    required String phoneNumber,
    required String otp,
  });

  }
