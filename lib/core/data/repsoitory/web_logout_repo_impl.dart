import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/dth_recharge_model.dart';
import 'package:maxpay/core/data/model/web_login_model.dart';
import 'package:maxpay/core/data/model/web_logout_mode.dart';
import 'package:maxpay/core/domain/repository/dth_recharge_repository.dart';
import 'package:maxpay/core/domain/repository/web_login_repository.dart';
import 'package:maxpay/core/domain/repository/web_logout_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class WebLogoutRepoImpl implements WebLogoutRepository {
  final ApiService apiService;

  WebLogoutRepoImpl(this.apiService);

  @override
  Future<Either<Failure, WebLogout>> weblogout({
    required String isweb,
 
  }) async {
    try {
      final response = await apiService.post(
        ApiRoutes.weblogin,
        data: {"is_web_login": isweb,},
      );

      AppLogger.logError("=========== 👍REQUEST BODY ===========");
      AppLogger.logError({
      "is_web_login": isweb,
      });

      AppLogger.logError("=========== 👍RAW RESPONSE ===========");
      AppLogger.logError(response);
      AppLogger.logError("====================================");
      final model = WebLogout.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
