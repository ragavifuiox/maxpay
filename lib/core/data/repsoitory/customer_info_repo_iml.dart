import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/custoer_info_model.dart';
import 'package:maxpay/core/data/model/payment_status_model.dart';
import 'package:maxpay/core/data/model/rehcarge_offer_model.dart';
import 'package:maxpay/core/domain/repository/customer_info_repository.dart';
import 'package:maxpay/core/domain/repository/offer_recharge_repository.dart';
import 'package:maxpay/core/domain/repository/paymnet_status_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class CustomerInfoRepoImpl implements CustomerInfoRepository {
  final ApiService apiService;

  CustomerInfoRepoImpl(this.apiService);

  @override
  Future<Either<Failure, CustomerInfo>> customerinfo({
    required String productid,
    required String customerid,
  }) async {
    try {
      final response = await apiService.post(
        ApiRoutes.customerInfo,
        data: {
          "product_id": productid,
          "customer_id": customerid
        },
      );

    
    

      AppLogger.logError("=========== 👍REQUEST BODY ===========");
      AppLogger.logError({
        "productid": productid,
        "customerid": customerid
      });

      AppLogger.logError("=========== 👍RAW RESPONSE ===========");
      AppLogger.logError(response);
      AppLogger.logError("====================================");
      final model = CustomerInfo.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
