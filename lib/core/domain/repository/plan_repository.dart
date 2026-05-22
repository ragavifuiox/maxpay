import 'package:dartz/dartz.dart';

import 'package:maxpay/core/data/model/plan_model.dart';
import 'package:maxpay/core/error/failure.dart';



abstract class PlanRepository {
  Future<Either<Failure, Plan >> getplan({
    required String planid,
  });
}
