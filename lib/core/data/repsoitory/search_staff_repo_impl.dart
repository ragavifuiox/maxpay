import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/add_staff_model.dart';
import 'package:maxpay/core/data/model/create_pin_model.dart';
import 'package:maxpay/core/data/model/login_model.dart';
import 'package:maxpay/core/data/model/otp_response_model.dart';
import 'package:maxpay/core/data/model/search_plan_model.dart';
import 'package:maxpay/core/data/model/search_staff_model.dart';
import 'package:maxpay/core/domain/repository/add_staff_repository.dart';
import 'package:maxpay/core/domain/repository/create_pin_repository.dart';
import 'package:maxpay/core/domain/repository/login_repository.dart';
import 'package:maxpay/core/domain/repository/otp_repository.dart';
import 'package:maxpay/core/domain/repository/search_plan_repository.dart';
import 'package:maxpay/core/domain/repository/search_staff_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class SearchStaffRepoImpl implements SearchStaffRepository {
  final ApiService apiService;

  SearchStaffRepoImpl(this.apiService);

  @override
  Future<Either<Failure, SearchStaff>> searchStaff({
    required String mobile,
  }) async {
    try {
    final response = await apiService.post(
  ApiRoutes.searchstaff,
  data: {
    "mobile": mobile,
  },
);

  

print("=========== 👍REQUEST BODY ===========");
print({
  "mobile": mobile,
});

print("=========== 👍RAW RESPONSE ===========");
print(response);
print("====================================");
      final model = SearchStaff.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


    