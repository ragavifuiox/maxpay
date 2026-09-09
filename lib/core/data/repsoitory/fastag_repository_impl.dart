import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/domain/repository/fastag_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/service/dio_error_handler.dart';

class FastagRepositoryImpl implements FastagRepository {
  final ApiService apiService;

  FastagRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, InstantPay>> fetchBill({
    required String productId,
    required String consumerNumber,
  }) async {
    try {
      final formData = FormData.fromMap({
        "product_id": productId,
        "consumer_number": consumerNumber,
      });

      final response = await apiService.post(
        ApiRoutes.fastagfetchbill,
        data: formData,
      );
      final model = InstantPay.fromJson(response);
      return Right(model);
    } on DioException catch (e, stackTrace) {
      print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(DioErrorHandler.handle(e));
    }
  }
}
