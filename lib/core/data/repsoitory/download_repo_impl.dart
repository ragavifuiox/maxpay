import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/download_model.dart';

import 'package:maxpay/core/domain/repository/downlaod_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class DownloadRepoImpl implements DownloadRepository {
  final ApiService apiService;
  DownloadRepoImpl(this.apiService);
  @override
  Future<Either<Failure, Download>> getDownload({
    required String successid,
  }) async {
    AppLogger.debugPrint(successid);
    try {
      final response = await apiService.get("${ApiRoutes.download}$successid");
      final model = Download.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

