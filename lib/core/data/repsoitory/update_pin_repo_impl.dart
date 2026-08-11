import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/update_pin_model.dart';
import 'package:maxpay/core/domain/repository/update_pin_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class UpdatePinRepoImpl implements UpdatePinRepository {
  final ApiService apiService;

  UpdatePinRepoImpl(this.apiService);

  @override
  Future<Either<Failure, UpdatePin>> updatepin({
    required String newpin,
    required String confirmpin,
  }) async {
    try {
    final response = await apiService.post(
  ApiRoutes.updatepin,
  data: {
    "new_pin": newpin,
    "confirm_pin": confirmpin,
  },
);

  

AppLogger.logError("=========== 👍REQUEST BODY ===========");
AppLogger.logError({
 "new_pin": newpin,
 "confirm_pin": confirmpin,
});

AppLogger.logError("=========== 👍RAW RESPONSE ===========");
AppLogger.logError(response);
AppLogger.logError("====================================");
      final model = UpdatePin.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


    
