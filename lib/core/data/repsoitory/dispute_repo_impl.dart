import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/dispute_model.dart';
import 'package:maxpay/core/domain/repository/dispute_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class DisputeRepoImpl implements DisputeRepository {
  final ApiService apiService;

  DisputeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, Dispute>> dispute({
    required String fromdate,
    required String todate,
   
  }) async {
    try {
    final response = await apiService.post(
  ApiRoutes.dispute,
  data: {
    "from_date": fromdate,
    "to_date": todate,
   
  },
);

AppLogger.logError("=========== 👍REQUEST BODY ===========");
AppLogger.logError({
  "from_date": fromdate,
    "to_date": todate,
    
});

AppLogger.logError("=========== 👍RAW RESPONSE ===========");
AppLogger.logError(response);
AppLogger.logError("====================================");
      final model = Dispute.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


    