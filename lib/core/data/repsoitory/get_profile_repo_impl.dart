import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/get_profile_model.dart';
import 'package:maxpay/core/data/model/privacy_link_model.dart';
import 'package:maxpay/core/domain/repository/get_profile_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class GetProfileRepoImpl implements GetProfileRepository {
  final ApiService apiService;
  GetProfileRepoImpl(this.apiService);

  @override
  Future<Either<Failure, MyProfile>> getProfile() async {
    try {
      final response = await apiService.get(ApiRoutes.getprofile);
      final model = MyProfile.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PrivacyPolicyResponse>> getPrivacyPolicy() async {
    try {
      final response = await apiService.get(ApiRoutes.privacyPolicy);

      return Right(PrivacyPolicyResponse.fromJson(response));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
