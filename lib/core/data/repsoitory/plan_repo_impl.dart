import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/plan_model.dart';
import 'package:maxpay/core/domain/repository/plan_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class PlanRepoImpl implements PlanRepository {
  final ApiService apiService;
  PlanRepoImpl(this.apiService);
  @override
  Future<Either<Failure, Plan>> getplan({
    required String productid,

  }) async {
    print(productid);
    try {
      final response = await apiService.get(
       "${ApiRoutes.plans}$productid"
      );
      final model = Plan.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}