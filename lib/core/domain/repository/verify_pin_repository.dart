import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/erify_pin_model.dart';

import 'package:maxpay/core/error/failure.dart';

abstract class VerifyPinRepository {
  Future<Either<Failure, VerifyPin>> Verifypin({
    required String pin,
    });

  }
