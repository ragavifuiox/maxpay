



import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/all_plan.dart';
import 'package:maxpay/core/data/model/compalints_model.dart';
import 'package:maxpay/core/domain/repository/all_plan%20_repository.dart';
import 'package:maxpay/core/domain/repository/compalints_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class AllPlanUsecase {
  final AllPlanRepository repository;
  AllPlanUsecase(this.repository);
  Future<Either<Failure, AllPlan>> call() {
    return repository.allplan();
  }
}
