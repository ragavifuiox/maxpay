import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/mobile_recharge.dart';
import 'package:maxpay/core/domain/repository/mobile_recharge_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class MobileRechargeRepoImpl implements MobileRechargeRepository {
  final ApiService apiService;

  MobileRechargeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, MobileRecharge>> mobileRecharge({
    required String productdetid,
    required String mobile,
    required String amount,
    required String paymentstatus,
    required String commission,
  }) async {
    try {
      final response = await apiService.post(
        ApiRoutes.mobilerecharge,
        data: {
          "product_id": productdetid,
          "mobile": mobile,
          "amount": amount,
          "payment_status": paymentstatus,
          "commission": commission,
        },
      );

      AppLogger.logError("=========== 👍REQUEST BODY ===========");
      AppLogger.logError({
        "product_id": productdetid,
        "mobile": mobile,
        "amount": amount,
        "payment_status": paymentstatus,
      });

      AppLogger.logError("=========== 👍RAW RESPONSE ===========");
      AppLogger.logError(response);
      AppLogger.logError("====================================");
      final model = MobileRecharge.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

