import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/create_pin_model.dart';

import 'package:maxpay/core/error/failure.dart';

abstract class CreatePinRepository {
  Future<Either<Failure, CreatePin>> createPin({
    required String pin,
    });

  }
