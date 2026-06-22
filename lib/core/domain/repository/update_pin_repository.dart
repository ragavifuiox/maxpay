import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/update_pin_model.dart';

import 'package:maxpay/core/error/failure.dart';

abstract class UpdatePinRepository {
  Future<Either<Failure, UpdatePin>> updatepin({
  required String newpin,
  required String confirmpin,
});

  }
