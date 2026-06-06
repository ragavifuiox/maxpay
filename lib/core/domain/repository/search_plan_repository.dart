import 'package:dartz/dartz.dart';

import 'package:maxpay/core/data/model/search_plan_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class SearchPlanRepository {
  Future<Either<Failure, SearchPlan>> searchPlans({
    required String planid,
    required String amount,
  });
}
  
