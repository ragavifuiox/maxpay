

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/wallet_trnasfer_detail.dart';
import 'package:maxpay/core/data/model/water_bill_page.dart';
import 'package:maxpay/core/domain/repository/wallet_trnsfer_detail_repository.dart';
import 'package:maxpay/core/domain/repository/water_bill_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/service/dio_error_handler.dart';

class WaterBillRepoImpl implements WaterBillRepository {
  final ApiService apiService;

  WaterBillRepoImpl(this.apiService);

 

@override
Future<Either<Failure, WaterBill>> waterbill({
  required String productId,
  required String customerId,
  
}) async {
  try {

  final formData = FormData.fromMap({
  "product_id": productId,
  "customer_id": customerId,
  
});

print("========= REQUEST =========");
for (var field in formData.fields) {
  print("${field.key} : ${field.value}");
}
final response = await apiService.post(
  ApiRoutes.wallettransferdetail,
  data: formData,
);
final model = WaterBill.fromJson(response);
    return Right(model);

} on DioException catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(DioErrorHandler.handle(e));
    }
}}

