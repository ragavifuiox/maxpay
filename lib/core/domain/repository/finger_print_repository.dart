import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/finger_print_model.dart';

import 'package:maxpay/core/error/failure.dart';

abstract class FingerPrintRepository {
  Future<Either<Failure, FingerPrint>> fingerprint({
  required int fingerprint,
});

  }
