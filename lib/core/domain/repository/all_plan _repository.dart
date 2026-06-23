import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/all_plan.dart';
import 'package:maxpay/core/error/failure.dart';


abstract class AllPlanRepository {
  Future<Either<Failure, AllPlan>> allplan();
}
