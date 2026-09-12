import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/electricity_confirm_model.dart';
import 'package:maxpay/core/domain/repository/electricity_confirm_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class ElectricityConfirmRepoImpl implements ElectricityConfirmRepository {
  final ApiService apiService;

  ElectricityConfirmRepoImpl(this.apiService);

  @override
  Future<Either<Failure, ElectricityConfirmModel>>
  getElectricityConfirmTransaction({
    required String productId,
    required String consumerNumber,
  }) async {
    try {
      final response = await apiService.get(
        "${ApiRoutes.electricityConfirm}$productId",
      );

      final decoded = response;
      Map<String, dynamic> jsonMap;

      if (decoded is List) {
        jsonMap = decoded.isNotEmpty ? Map<String, dynamic>.from(decoded) : {};
      } else {
        jsonMap = decoded;
      }

      final model = ElectricityConfirmModel.fromJson(jsonMap);
      return Right(model);
    } catch (e, stackTrace) {
      print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
