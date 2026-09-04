

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/check_operator_model.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/domain/repository/cable_tv_bill_repository.dart';
import 'package:maxpay/core/domain/repository/check_operator_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class CableTvBillRepoImpl implements CableTvBillRepository {
  final ApiService apiService;

  CableTvBillRepoImpl(this.apiService);

  @override
  Future<Either<Failure, InstantPay>> cabletvbill({
    required String productid,
    required String consumernumber,
  }) async {
    try {
       final response = await apiService.post(
  ApiRoutes.checkoperator,  
  data: {
   
    "product_d": productid,
    "consumer_number": consumernumber,
    
  },
);
AppLogger.logError("=========== 👍REQUEST BODY ===========");
AppLogger.logError({
 
    "product_d": productid,
    "consumer_number": consumernumber,
});

AppLogger.logError("=========== 👍RAW RESPONSE ===========");
AppLogger.logError(response);
AppLogger.logError("====================================");

      final model = InstantPay.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

 



    
