import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/add_staff_model.dart';
import 'package:maxpay/core/data/model/create_pin_model.dart';
import 'package:maxpay/core/data/model/login_model.dart';
import 'package:maxpay/core/data/model/otp_response_model.dart';
import 'package:maxpay/core/data/model/search_plan_model.dart';
import 'package:maxpay/core/domain/repository/add_staff_repository.dart';
import 'package:maxpay/core/domain/repository/create_pin_repository.dart';
import 'package:maxpay/core/domain/repository/login_repository.dart';
import 'package:maxpay/core/domain/repository/otp_repository.dart';
import 'package:maxpay/core/domain/repository/search_plan_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class SearchPlanRepoImpl implements SearchPlanRepository {
  final ApiService apiService;

  SearchPlanRepoImpl(this.apiService);

  @override
  Future<Either<Failure, SearchPlan>> searchPlans({
    required String planid,
    required String amount,
  }) async {
    try {
    final response = await apiService.post(
  ApiRoutes.searchplans,
  data: {
    "product_id": planid,
    "amount": amount,
  },
);

print("=========== 👍REQUEST BODY ===========");
print({
  "product_id": planid,
  "amount": amount,
});

print("=========== 👍RAW RESPONSE ===========");
print(response);
print("====================================");
      final model = SearchPlan.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


    