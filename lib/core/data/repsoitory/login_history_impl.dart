

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/login_history_model.dart';
import 'package:maxpay/core/domain/repository/login_history_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class LoginHistoryImpl implements LoginHistoryRepository {
  final ApiService apiService;

  LoginHistoryImpl(this.apiService);

  @override
  Future<Either<Failure, LoginHistory>> loginhistory({
    required String fromdate,
    required String todate,
    required String search,
  }) async {
    try {
    final response = await apiService.post(
  ApiRoutes.loginhistory,
  data: {
    "from_date": fromdate,
    "to_date": todate,
    "search": search,
  },
);

AppLogger.logError("=========== 👍REQUEST BODY ===========");
AppLogger.logError({
 "from_date": fromdate,
    "to_date": todate,
    "search": search,
});

AppLogger.logError("=========== 👍RAW RESPONSE ===========");
AppLogger.logError(response);
AppLogger.logError("====================================");
      final model = LoginHistory.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


    