import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/delete_staff_model.dart';
import 'package:maxpay/core/domain/repository/delete_staff_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class DeleteStaffRepoImpl implements DeleteStaffRepository {
  final ApiService apiService;

  DeleteStaffRepoImpl(this.apiService);

  @override
  Future<Either<Failure, DeleteStaffModel>> deleteStaff({
    required String staffId,
  }) async {
    try {
      final response = await apiService.post(
        ApiRoutes.deletestaff,
        data: {"staff_id": staffId},
      );

      AppLogger.logError("=========== 👍REQUEST BODY ===========");
      AppLogger.logError({"staff_id": staffId});

      AppLogger.logError("=========== 👍RAW RESPONSE ===========");
      AppLogger.logError(response);
      AppLogger.logError("====================================");

      final model = DeleteStaffModel.fromJson(response);

      return Right(model);
    } catch (e, stackTrace) {
      print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      AppLogger.logError("DELETE STAFF ERROR");
      AppLogger.logError(e);

      if (e is DioException) {
        final data = e.response?.data;

        AppLogger.logError("API ERROR RESPONSE");
        AppLogger.logError(data);

        return Left(
          ServerFailure(message: data["message"] ?? "Something went wrong"),
        );
      }

      return Left(ServerFailure(message: e.toString()));
    }
  }
}
