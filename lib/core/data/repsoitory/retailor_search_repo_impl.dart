import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/retailer_search_model.dart';
import 'package:maxpay/core/data/model/search_plan_model.dart';
import 'package:maxpay/core/domain/repository/retailor_search_repository.dart';
import 'package:maxpay/core/domain/repository/search_plan_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class RetailorSearchRepoImpl implements RetailorSearchRepository {
  final ApiService apiService;

  RetailorSearchRepoImpl(this.apiService);

  @override
  Future<Either<Failure, RetailorSearch>> searchretailor({
    required String regmob,
  }) async {
    try {
    final response = await apiService.post(
  ApiRoutes.retailorsearch,
  data: {
    "reg_mobile_number": regmob, 
  
  },
);

AppLogger.logError("=========== 👍REQUEST BODY ===========");
AppLogger.logError({
 "reg_mobile_number": regmob, 
  
});

AppLogger.logError("=========== 👍RAW RESPONSE ===========");
AppLogger.logError(response);
AppLogger.logError("====================================");
      final model = RetailorSearch.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


    
