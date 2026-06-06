import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/finger_print_model.dart';
import 'package:maxpay/core/domain/repository/finger_print_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class FingerPrintRepoImpl
    implements FingerPrintRepository {

  final ApiService apiService;

  FingerPrintRepoImpl(
    this.apiService,
  );

  @override
  Future<Either<Failure, FingerPrint>>
      fingerprint({
    required int fingerprint,
  }) async {

    try {

      AppLogger.logError(
          "=========== API REQUEST ==========");
          
      AppLogger.logError(
        "is_finger_print : $fingerprint",
      );

      final response =
          await apiService.post(
        ApiRoutes.fingerprint,

        data: {
          "is_finger_print":
              fingerprint,
        },
      );

      AppLogger.logError(
          "=========== API RESPONSE ==========");

      AppLogger.logError(response);

      final model =
          FingerPrint.fromJson(
        response,
      );

      return Right(model);

    } catch (e) {

      AppLogger.logError(
          "=========== API ERROR ==========");

      AppLogger.logError(e.toString());

      return Left(
        ServerFailure(
          message: e.toString(),
        ),
      );
    }
  }
}