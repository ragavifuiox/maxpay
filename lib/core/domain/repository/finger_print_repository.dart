import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/create_pin_model.dart';
import 'package:maxpay/core/data/model/finger_print_model.dart';

import 'package:maxpay/core/data/model/login_model.dart';
import 'package:maxpay/core/data/model/otp_response_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class FingerPrintRepository {
  Future<Either<Failure, FingerPrint>> fingerprint({
  required int fingerprint,
});

  }
