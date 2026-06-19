import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/profile_update_model.dart';
import 'package:maxpay/core/domain/repository/profile_update_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class UpdateProfileRepoImpl implements ProfileUpdateRepository {
  final ApiService apiService;

  UpdateProfileRepoImpl(this.apiService);

  @override
  Future<Either<Failure, ProfileUpdate>> updateprofile({
    required String pincode,
    required String email,
    required String mobilenumber,
    required String profileimage,
    required String name,
    
  }) async {
    try {
    final response = await apiService.post(
  ApiRoutes.searchplans,
  data: {
    "pincode": pincode,
    "email": email,
    "reg_mobile_number": mobilenumber,
    "profile_image": profileimage,
    "retailor_name": name,
  },
);

AppLogger.logError("=========== 👍REQUEST BODY ===========");
AppLogger.logError({
  "pincode": pincode,
    "email": email,
    "reg_mobile_number": mobilenumber,
    "profile_image": profileimage,
    "retailor_name": name,
});

AppLogger.logError("=========== 👍RAW RESPONSE ===========");
AppLogger.logError(response);
AppLogger.logError("====================================");
      final model = ProfileUpdate.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


    