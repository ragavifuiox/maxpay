import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/search_dth_model.dart';
import 'package:maxpay/core/domain/repository/search_dth_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/service/dio_error_handler.dart';

class SearchDthRepoImpl implements SearchDthRepository {
  final ApiService apiService;

  SearchDthRepoImpl(this.apiService);

  @override
  Future<Either<Failure, SearchDth>> searchdth({
    required String planid,
    required String amount,
  }) async {
    try {
      final response = await apiService.post(
        ApiRoutes.searchdth,
        data: {
          "product_id": planid,
          "amount": amount,
        },
      );

      AppLogger.logError("=========== REQUEST BODY ===========");
      AppLogger.logError({
        "product_id": planid,
        "amount": amount,
      });

      AppLogger.logError("=========== RAW RESPONSE ===========");
      AppLogger.logError(response);
      AppLogger.logError("===================================");

      final model = SearchDth.fromJson(response);

      return Right(model);
    } on DioException catch (e) {
      return Left(DioErrorHandler.handle(e));
    } catch (e) {
      AppLogger.logError("Unexpected Error: $e");
      return Left(
        ServerFailure(message: "Something went wrong"),
      );
    }
  }
}