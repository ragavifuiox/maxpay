import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/dth_recharge_model.dart';
import 'package:maxpay/core/data/model/web_login_model.dart';
import 'package:maxpay/core/domain/repository/dth_recharge_repository.dart';
import 'package:maxpay/core/domain/repository/web_login_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class WebLoginRepoImpl implements WebLoginRepository {
  final ApiService apiService;

  WebLoginRepoImpl(this.apiService);

  @override
  Future<Either<Failure, WebLogin>> weblogin({
    required String userid,
 
  }) async {
    try {
      final response = await apiService.post(
        ApiRoutes.weblogin,
        data: {"qr_user_id": userid,},
      );

      AppLogger.logError("=========== 👍REQUEST BODY ===========");
      AppLogger.logError({
      "qr_user_id": userid,
      });

      AppLogger.logError("=========== 👍RAW RESPONSE ===========");
      AppLogger.logError(response);
      AppLogger.logError("====================================");
      final model = WebLogin.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
