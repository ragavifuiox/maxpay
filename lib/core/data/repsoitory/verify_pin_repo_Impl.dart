import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/erify_pin_model.dart';
import 'package:maxpay/core/domain/repository/verify_pin_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class VerifyPinRepoImpl implements VerifyPinRepository {
  final ApiService apiService;

  VerifyPinRepoImpl(this.apiService);

  @override
  Future<Either<Failure, VerifyPin>> verifypin({required String pin}) async {
    try {
      final response = await apiService.post(
        ApiRoutes.verifypin,
        data: {"pin": pin},
      );

      final model = VerifyPin.fromJson(response);
      return Right(model);
    } on DioException catch (e) {
      AppLogger.logError(e.response);
      return Left(
        ServerFailure(
          message:
              e.response?.data['message'].toString() ??
              "An Authorised Error Occured",
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
