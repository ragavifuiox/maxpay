import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/refund_model.dart';
import 'package:maxpay/core/domain/repository/refund_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class RefundRepoImpl implements RefundRepository {
  final ApiService apiService;

  RefundRepoImpl(this.apiService);

  @override
  Future<Either<Failure, Refund>> refund({
    required String fromdate,
    required String todate,
    required String search,
  }) async {
    try {
    final response = await apiService.post(
  ApiRoutes.refund,
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
      final model = Refund.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


    