import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/banner_model.dart';
import 'package:maxpay/core/domain/repository/banner_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class BannerRepoImpl implements BannerRepository {
  final ApiService apiService;
  BannerRepoImpl(this.apiService);

  @override
  Future<Either<Failure, Banner>> banner() async {
    try {
      final response = await apiService.get(ApiRoutes.banner);
      final model = Banner.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

