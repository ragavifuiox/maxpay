import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/search_plan_model.dart';
import 'package:maxpay/core/domain/repository/search_plan_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class SearchPlanRepoImpl implements SearchPlanRepository {
  final ApiService apiService;

  SearchPlanRepoImpl(this.apiService);

  @override
  Future<Either<Failure, SearchPlan>> searchPlans({
    required String planid,
    required String amount,
  }) async {
    try {
    final response = await apiService.post(
  ApiRoutes.searchplans,
  data: {
    "product_id": planid,
    "amount": amount,
  },
);

AppLogger.logError("=========== 👍REQUEST BODY ===========");
AppLogger.logError({
  "product_id": planid,
  "amount": amount,
});

AppLogger.logError("=========== 👍RAW RESPONSE ===========");
AppLogger.logError(response);
AppLogger.logError("====================================");
      final model = SearchPlan.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


    
