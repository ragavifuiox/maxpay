import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/fastag_confirm_model.dart';
import 'package:maxpay/core/domain/repository/fastag_confirm_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class FastagConfirmRepoImpl implements FastagConfirmRepository {
  final ApiService apiService;

  FastagConfirmRepoImpl(this.apiService);

  @override
  Future<Either<Failure, FastagConfirmModel>> getFastagConfirmTransaction({
    required String productdetid,
  }) async {
    AppLogger.debugPrint(productdetid);
    try {
      final response = await apiService.get(
        "${ApiRoutes.fastagConfirm}$productdetid",
      );
      final decoded = response;

      Map<String, dynamic> jsonMap;

      if (decoded is List) {
        jsonMap = decoded.isNotEmpty ? Map<String, dynamic>.from(decoded) : {};
      } else {
        jsonMap = decoded;
      }

      final model = FastagConfirmModel.fromJson(jsonMap);
      return Right(model);
    } catch (e, stackTrace) {
      print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
