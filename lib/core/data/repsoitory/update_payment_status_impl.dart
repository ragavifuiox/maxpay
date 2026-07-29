import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/update_payment_status.dart';
import 'package:maxpay/core/domain/repository/update_payment_status_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class UpdatePaymentStatusImpl implements UpdatePaymentStatusRepository {
  final ApiService apiService;

  UpdatePaymentStatusImpl(this.apiService);

  @override
  Future<Either<Failure, UpdatePaymentStatus>> udpatestatus({
    required String rechargeid,
    required String status,
  }) async {
    try {
    final response = await apiService.post(
  ApiRoutes.updatepaymentStatus,
  data: {
    "recharge_id": rechargeid,
    "status": status,
  },
);

  

AppLogger.logError("=========== 👍REQUEST BODY ===========");
AppLogger.logError({
 "recharge_id": rechargeid,
    "status": status,
});

AppLogger.logError("=========== 👍RAW RESPONSE ===========");
AppLogger.logError(response);
AppLogger.logError("====================================");
      final model = UpdatePaymentStatus.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


    