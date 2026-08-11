import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/submit_dispute_model.dart';
import 'package:maxpay/core/domain/repository/submit_dsipute_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class SubmitDisputeRepoImpl implements SubmitDsiputeRepository {
  final ApiService apiService;

  SubmitDisputeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, SubmitDispute>> submitdsipute({
    required String description,
    required String subject,
    required String rechargeid,
  }) async {
    try {
    final response = await apiService.post(
  ApiRoutes.SubmitDispute,
  data: {
    "recharge_id": rechargeid,
    "description": description,
    "subject": subject,
  },
);

  

AppLogger.logError("=========== 👍REQUEST BODY ===========");
AppLogger.logError({
   "recharge_id": rechargeid,
    "description": description,
    "subject": subject,
});

AppLogger.logError("=========== 👍RAW RESPONSE ===========");
AppLogger.logError(response);
AppLogger.logError("====================================");
      final model = SubmitDispute.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


    
