import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/get_profile_model.dart';
import 'package:maxpay/core/data/model/news_model.dart';
import 'package:maxpay/core/domain/repository/get_profile_repository.dart';
import 'package:maxpay/core/domain/repository/news_repository.dart';
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
}
