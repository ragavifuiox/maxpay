import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/login_model.dart';
import 'package:maxpay/core/data/model/otp_response_model.dart';
import 'package:maxpay/core/domain/repository/login_repository.dart';
import 'package:maxpay/core/domain/repository/otp_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class OtpRepoImpl implements OtpRepository {
  final ApiService apiService;

  OtpRepoImpl(this.apiService);

  @override
  Future<Either<Failure, OtpResponse>> otp({
    required String phoneNumber,
   
    required String otp,
  }) async {
    try {
      final response = await apiService.post(
        ApiRoutes.verifyotp,
        data: {
          "phone_number": phoneNumber,
          "otp": otp,
          

        },
      );

      final model = OtpResponse.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
