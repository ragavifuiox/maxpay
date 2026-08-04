import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/dth_recharge_model.dart';
import 'package:maxpay/core/domain/repository/dth_recharge_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class DthRechargeRepoImpl implements DthRechargeRepository {
  final ApiService apiService;

  DthRechargeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, DthRecharge>> Dthrecharge({
    required String productdetid,
    required String mobile,
    required String amount,
    required String paymentstatus,
    required String commission,
  }) async {
    try {
      final response = await apiService.post(
        ApiRoutes.Dthrecharge,
        data: {
          "product_id": productdetid,
          "number": mobile,
          "amount": amount,
          "payment_status": paymentstatus,
          "commission": commission,
        },
      );

      AppLogger.logError("=========== 👍REQUEST BODY ===========");
      AppLogger.logError({
        "product_id": productdetid,
        "number": mobile,
        "amount": amount,
      });

      AppLogger.logError("=========== 👍RAW RESPONSE ===========");
      AppLogger.logError(response);
      AppLogger.logError("====================================");
      final model = DthRecharge.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
