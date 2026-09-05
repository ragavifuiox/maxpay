import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/store_version_model.dart';
import 'package:maxpay/core/domain/repository/store_version_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class StoreVersionRepoImpl implements StoreVersionRepository {
  final ApiService apiService;

  StoreVersionRepoImpl(this.apiService);

  @override
  Future<Either<Failure, StoreVersionModel>> storeVersion({
    required String version,
  }) async {
    try {
      AppLogger.debugPrint(
        "🚀 [StoreVersionRepoImpl] Request URL: ${ApiRoutes.storeVersion}",
      );
      AppLogger.debugPrint(
        "🚀 [StoreVersionRepoImpl] Request Payload: {\"version\": \"$version\"}",
      );

      final response = await apiService.post(
        ApiRoutes.storeVersion,
        data: FormData.fromMap({"version": version}),
      );

      AppLogger.debugPrint("✅ [StoreVersionRepoImpl] Response data: $response");

      final model = StoreVersionModel.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) {
      AppLogger.logError("❌ [StoreVersionRepoImpl] API EXCEPTION: $e");
      AppLogger.logError("❌ [StoreVersionRepoImpl] StackTrace: $stackTrace");

      if (e is DioException) {
        final data = e.response?.data;
        AppLogger.logError(
          "❌ [StoreVersionRepoImpl] DioException response data: $data",
        );

        if (data is Map<String, dynamic>) {
          return Left(
            ServerFailure(
              message: data['message'] ?? "Failed to fetch store version",
            ),
          );
        }
      }

      return Left(ServerFailure(message: "Something went wrong"));
    }
  }
}
