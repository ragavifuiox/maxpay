import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/all_plan.dart';
import 'package:maxpay/core/domain/repository/all_plan_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class AllPlanRepoImpl implements AllPlanRepository {
  final ApiService apiService;
  AllPlanRepoImpl(this.apiService);

  @override
  Future<Either<Failure, AllPlan>> allplan() async {
    try {
      final response = await apiService.get(ApiRoutes.allplan);
      final model = AllPlan.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

