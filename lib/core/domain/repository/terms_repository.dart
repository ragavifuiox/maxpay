

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/terms_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class TermsRepository {
  Future<Either<Failure, Terms>> terms();
}
