import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/update_otp_model.dart';
import 'package:maxpay/core/data/model/update_pin_model.dart';
import 'package:maxpay/core/data/model/update_profile_otp_model.dart';
import 'package:maxpay/core/domain/repository/update_pin_repository.dart';
import 'package:maxpay/core/domain/repository/update_profile_otp_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class UpdateProfileOtpRepoImpl implements UpdateProfileOtpRepository {
  final ApiService apiService;

  UpdateProfileOtpRepoImpl(this.apiService);

  @override
  Future<Either<Failure, UpdateprofileOtp>> updateotp({
    required String otp,

  }) async {
    try {
    final response = await apiService.post(
  ApiRoutes.updateprofileotp,
  data: {
    "otp": otp,
    
  },
);

  

AppLogger.logError("=========== 👍REQUEST BODY ===========");
AppLogger.logError({
 "otp": otp,

});

AppLogger.logError("=========== 👍RAW RESPONSE ===========");
AppLogger.logError(response);
AppLogger.logError("====================================");
      final model = UpdateprofileOtp.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


    