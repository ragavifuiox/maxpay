import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/active_user_model.dart';
import 'package:maxpay/core/domain/repository/active_user_reposiotry.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class ActiveRepoImpl implements ActiveUserRepository {
  final ApiService apiService;

  ActiveRepoImpl(this.apiService);

  @override
  Future<Either<Failure, ActiveUser>> Active({
    required String isActive,
  }) async {
    try {

  final response = await apiService.post(
  ApiRoutes.activeuser,
  data: {
    "is_active": isActive,
  },
);

AppLogger.logError("=========== 👍REQUEST BODY ===========");
AppLogger.logError({
  "is_active": isActive,
});

AppLogger.logError("=========== 👍RAW RESPONSE ===========");
AppLogger.logError(response);
AppLogger.logError("====================================");
      final model = ActiveUser.fromJson(response);

      
      return Right(model);
   } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
  AppLogger.logError("ADD STAFF ERROR");
  AppLogger.logError(e);

  if (e is DioException) {
    final data = e.response?.data;

    AppLogger.logError("API ERROR RESPONSE");
    AppLogger.logError(data);

    return Left(
      ServerFailure(
        message: data["message"] ?? "Something went wrong",
      ),
    );
  }

  return Left(
    ServerFailure(
      message: e.toString(),
    ),
  );

  }
  }
}


    
