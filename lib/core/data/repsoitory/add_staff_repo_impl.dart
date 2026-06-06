import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/add_staff_model.dart';
import 'package:maxpay/core/domain/repository/add_staff_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class AddStaffRepoImpl implements AddStaffRepository {
  final ApiService apiService;

  AddStaffRepoImpl(this.apiService);

  @override
  Future<Either<Failure, AddStaff>> addStaff({
    required String name,
    required String phone,
    required String package,
  }) async {
    try {
    final response = await apiService.post(
  ApiRoutes.addstaff,
  data: {
    "name": name,
    "mobile": phone,
    "commission_package": package,
  },
);

print("=========== 👍REQUEST BODY ===========");
print({
  "name": name,
  "mobile": phone,
});

print("=========== 👍RAW RESPONSE ===========");
print(response);
print("====================================");
      final model = AddStaff.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


    