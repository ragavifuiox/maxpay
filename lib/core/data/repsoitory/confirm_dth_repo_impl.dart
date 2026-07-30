import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/confirm_dth_model.dart';
import 'package:maxpay/core/domain/repository/confirm_dth_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/service/dio_error_handler.dart';

class ConfirmDthRepoImpl implements ConfirmDthRepository {
  final ApiService apiService;
  ConfirmDthRepoImpl(this.apiService);
  @override
  Future<Either<Failure, ConfirmDth>> getdthconfirm({
    required String prodcutdetid,
  }) async {
    AppLogger.debugPrint(prodcutdetid);
    try {
      final response = await apiService.get(
        "${ApiRoutes.confirmdth}$prodcutdetid",
      );
      final decoded = response;

      Map<String, dynamic> jsonMap;

      if (decoded is List) {
        jsonMap = decoded.isNotEmpty ? Map<String, dynamic>.from(decoded) : {};
      } else {
        jsonMap = decoded;
      }

      final model = ConfirmDth.fromJson(jsonMap);
      return Right(model);
    } catch (e) {
      return Left(DioErrorHandler.handle(e));
    }
  }
}
