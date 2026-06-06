import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/create_pin_model.dart';
import 'package:maxpay/core/domain/repository/create_pin_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class CreatePinRepoImpl implements CreatePinRepository {
  final ApiService apiService;

  CreatePinRepoImpl(this.apiService);

  @override
  Future<Either<Failure, CreatePin>> createPin({
    required String pin,
  }) async {
    try {
      final response = await apiService.post(
        ApiRoutes.createpin,
        data: {
          "pin": pin,
        },
      );

      final model = CreatePin.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
