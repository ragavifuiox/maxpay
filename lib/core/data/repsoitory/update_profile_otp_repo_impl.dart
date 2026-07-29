import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/update_profile_otp_model.dart';
import 'package:maxpay/core/domain/repository/update_profile_otp_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class UpdateProfileOtpRepoImpl implements UpdateProfileOtpRepository {
  final ApiService apiService;

  UpdateProfileOtpRepoImpl(this.apiService);

  @override
  Future<Either<Failure, UpdateprofileOtp>> updateotp({
  required String otp,
  required String mobile,
}) async {
  try {

    print("=========== REQUEST BODY ===========");
    print({
      "otp": otp,
      "mobile": mobile,
    });

    final response = await apiService.post(
      ApiRoutes.updateprofileotp,
      data: {
        "otp": otp,
        "mobile": mobile,
      },
    );

    print("=========== RESPONSE ===========");
    print(response);

    final model = UpdateprofileOtp.fromJson(response);
    return Right(model);

  } catch (e) {
    return Left(ServerFailure(message: e.toString()));
  }
}
}


    