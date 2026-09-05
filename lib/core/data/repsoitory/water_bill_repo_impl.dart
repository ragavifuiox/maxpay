import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/domain/repository/water_bill_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/service/dio_error_handler.dart';

class WaterBillRepoImpl implements WaterBillRepository {
  final ApiService apiService;

  WaterBillRepoImpl(this.apiService);

  @override
  Future<Either<Failure, InstantPay>> waterbill({
    required String productId,
    required String customerId,
  }) async {
    try {
      final formData = FormData.fromMap({
        "product_id": productId,
        "customer_id": customerId,
      });

      final response = await apiService.post(
        ApiRoutes.waterbill,
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
