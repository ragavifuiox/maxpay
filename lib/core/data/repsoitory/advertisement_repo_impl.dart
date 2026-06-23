import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/advertisement_model.dart';
import 'package:maxpay/core/data/model/banner_model.dart';
import 'package:maxpay/core/data/model/grade_model.dart';
import 'package:maxpay/core/domain/repository/advertisement_repository.dart';
import 'package:maxpay/core/domain/repository/banner_repository.dart';
import 'package:maxpay/core/domain/repository/grade_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class AdvertisementRepoImpl implements AdvertisementRepository {
  final ApiService apiService;
  AdvertisementRepoImpl(this.apiService);

  @override
  Future<Either<Failure, Advertisement>> getadv() async {
    try {
      final response = await apiService.get(ApiRoutes.advertisement);
      final model = Advertisement.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
