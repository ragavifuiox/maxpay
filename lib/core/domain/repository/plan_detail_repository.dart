import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/plan_detail_model.dart';

import 'package:maxpay/core/error/failure.dart';



abstract class PlanDetailRepository {
  Future<Either<Failure, PlanDetail >> getplandetail({
    required String planid,
  });
}
