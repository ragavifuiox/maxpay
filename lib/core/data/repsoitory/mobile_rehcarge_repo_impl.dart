import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/add_staff_model.dart';
import 'package:maxpay/core/data/model/create_pin_model.dart';
import 'package:maxpay/core/data/model/login_model.dart';
import 'package:maxpay/core/data/model/mobile_recharge.dart';
import 'package:maxpay/core/data/model/otp_response_model.dart';
import 'package:maxpay/core/domain/repository/add_staff_repository.dart';
import 'package:maxpay/core/domain/repository/create_pin_repository.dart';
import 'package:maxpay/core/domain/repository/login_repository.dart';
import 'package:maxpay/core/domain/repository/mobile_recharge_repository.dart';
import 'package:maxpay/core/domain/repository/otp_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class MobileRechargeRepoImpl implements MobileRechargeRepository {
  final ApiService apiService;

  MobileRechargeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, MobileRecharge>> mobileRecharge({
    required String productdetid,
    required String mobile,
    required String amount,
  }) async {
    try {
    final response = await apiService.post(
  ApiRoutes.mobilerecharge,
  data: {
    "product_id": productdetid,
    "mobile": mobile,
    "amount": amount,
  },
);

print("=========== 👍REQUEST BODY ===========");
print({
  "productdetid": productdetid,
  "mobile": mobile,
  "amount": amount,
});

print("=========== 👍RAW RESPONSE ===========");
print(response);
print("====================================");
      final model = MobileRecharge.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


    