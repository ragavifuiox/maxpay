

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/wallet_trnasfer_detail.dart';
import 'package:maxpay/core/domain/repository/wallet_trnsfer_detail_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/service/dio_error_handler.dart';

class WalletTrnasferDetailRepoImpl implements WalletTrnsferDetailRepository {
  final ApiService apiService;

  WalletTrnasferDetailRepoImpl(this.apiService);

 

@override
Future<Either<Failure, WalletTransferDetail>> walletransferdetail({
  required String search,
  required String startdate,
  required String todate,
  required String transfertype,
  
}) async {
  try {

  final formData = FormData.fromMap({
  "transaction_type": transfertype,
  "from_date": startdate,
  "to_date": todate,
  "search": search,   // was: todate — this silently broke search
});

print("========= REQUEST =========");
for (var field in formData.fields) {
  print("${field.key} : ${field.value}");
}
final response = await apiService.post(
  ApiRoutes.wallettransferdetail,
  data: formData,
);
final model = WalletTransferDetail.fromJson(response);
    return Right(model);

} on DioException catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
}}
