import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/news_model.dart';
import 'package:maxpay/core/domain/repository/news_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';


class GetNewsRepoImpl implements GetNewsRepository {
  final ApiService apiService;
  GetNewsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, News>> getNews() async {
    try {
      final response = await apiService.get(ApiRoutes.news);
      final model = News.fromJson(response);
      return Right(model);
    } catch (e) {
      AppLogger.logError("Api ${ApiRoutes.news}$e");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
