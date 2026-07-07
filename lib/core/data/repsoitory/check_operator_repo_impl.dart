

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/add_staff_model.dart';
import 'package:maxpay/core/data/model/check_operator_model.dart';
import 'package:maxpay/core/domain/repository/add_staff_repository.dart';
import 'package:maxpay/core/domain/repository/check_operator%20repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class CheckOperatorRepoImpl implements CheckOperatorRepository {
  final ApiService apiService;

  CheckOperatorRepoImpl(this.apiService);

  @override
  Future<Either<Failure, CheckOperator>> checkoperator({
    required String mobile,
  }) async {
    try {
       final response = await apiService.post(
  ApiRoutes.checkoperator,
  data: {
   
    "mobile": mobile,
    
  },
);
AppLogger.logError("=========== 👍REQUEST BODY ===========");
AppLogger.logError({
 
  "mobile": mobile,
});

AppLogger.logError("=========== 👍RAW RESPONSE ===========");
AppLogger.logError(response);
AppLogger.logError("====================================");

      final model = CheckOperator.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

 



    