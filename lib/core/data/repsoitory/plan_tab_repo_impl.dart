import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/plan_tab_model.dart';
import 'package:maxpay/core/domain/repository/plan_tab_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class PlanTabRepoImpl implements PlanTabRepository {
  final ApiService apiService;
  PlanTabRepoImpl(this.apiService);

  @override
  Future<Either<Failure, PlanTab>> getPlanTab() async {
    try {
      final response = await apiService.get(ApiRoutes.plantab);
      final model = PlanTab.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

