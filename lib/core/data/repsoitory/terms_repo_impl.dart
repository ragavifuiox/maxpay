import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/terms_model.dart';
import 'package:maxpay/core/domain/repository/terms_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/service/dio_error_handler.dart';

class TermsRepoImpl implements TermsRepository {
  final ApiService apiService;

  TermsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, Terms>> terms() async {
    try {
      final response = await apiService.get(ApiRoutes.terms);
      final model = Terms.fromJson(response);
      return Right(model);
    } on DioException catch (e, stackTrace) {
      print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(DioErrorHandler.handle(e));
    } catch (e, stackTrace) {
      print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      AppLogger.logError("Api ${ApiRoutes.terms}$e");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
