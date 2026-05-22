import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/finger_print_model.dart';
import 'package:maxpay/core/domain/repository/finger_print_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

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

      print(
          "=========== API REQUEST ==========");
          
      print(
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

      print(
          "=========== API RESPONSE ==========");

      print(response);

      final model =
          FingerPrint.fromJson(
        response,
      );

      return Right(model);

    } catch (e) {

      print(
          "=========== API ERROR ==========");

      print(e.toString());

      return Left(
        ServerFailure(
          message: e.toString(),
        ),
      );
    }
  }
}