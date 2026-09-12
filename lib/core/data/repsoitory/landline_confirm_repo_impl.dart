import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/landline_confirm_model.dart';
import 'package:maxpay/core/domain/repository/landline_confirm_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class LandlineConfirmRepoImpl implements LandlineConfirmRepository {
  final ApiService apiService;

  LandlineConfirmRepoImpl(this.apiService);

  @override
  Future<Either<Failure, LandlineConfirmModel>> getLandlineConfirmTransaction({
    required String productdetid,
  }) async {
    AppLogger.debugPrint(productdetid);
    try {
      final response = await apiService.get(
        "${ApiRoutes.landlineConfirm}$productdetid",
      );
      final decoded = response;

      Map<String, dynamic> jsonMap;

      if (decoded is List) {
        jsonMap = decoded.isNotEmpty ? Map<String, dynamic>.from(decoded) : {};
      } else {
        jsonMap = decoded;
      }

      final model = LandlineConfirmModel.fromJson(jsonMap);
      return Right(model);
    } catch (e, stackTrace) {
      print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
