import 'package:dartz/dartz.dart';

import 'package:maxpay/core/data/model/login_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, Login>> login({
    required String phoneNumber,
    required String name,
    required String pincode,
    required String countrycode ,
  });
}
