import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/update_send_otmodel.dart';
import 'package:maxpay/core/domain/repository/update_send_otp_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class UpdateSendOtpImpl implements UpdateSendOtpRepository {
  final ApiService apiService;

  UpdateSendOtpImpl(this.apiService);

  @override
  Future<Either<Failure, SendUpdatePinOtpResponse>> updatePin() async {
    try {
      final response = await apiService.post(
        ApiRoutes.sendotp,
        data: {}, // Empty body
      );

      AppLogger.logError("=========== 👍 RAW RESPONSE ===========");
      AppLogger.logError(response);
      AppLogger.logError("======================================");

      final model = SendUpdatePinOtpResponse.fromJson(response);

      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}