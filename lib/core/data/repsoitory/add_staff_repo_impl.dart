import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/add_staff_model.dart';
import 'package:maxpay/core/domain/repository/add_staff_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

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

AppLogger.logError("=========== 👍REQUEST BODY ===========");
AppLogger.logError({
  "name": name,
  "mobile": phone,
});

AppLogger.logError("=========== 👍RAW RESPONSE ===========");
AppLogger.logError(response);
AppLogger.logError("====================================");
      final model = AddStaff.fromJson(response);

      
      return Right(model);
   } catch (e) {
  AppLogger.logError("ADD STAFF ERROR");
  AppLogger.logError(e);

  if (e is DioException) {
    final data = e.response?.data;

    AppLogger.logError("API ERROR RESPONSE");
    AppLogger.logError(data);

    return Left(
      ServerFailure(
        message: data["message"] ?? "Something went wrong",
      ),
    );
  }

  return Left(
    ServerFailure(
      message: e.toString(),
    ),
  );

  }
  }
}


    