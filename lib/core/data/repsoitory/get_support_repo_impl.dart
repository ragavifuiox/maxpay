import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/support_model.dart';
import 'package:maxpay/core/domain/repository/support_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class SupportRepoImpl implements SupportRepository {
  final ApiService apiService;
  SupportRepoImpl(this.apiService);

  @override
  Future<Either<Failure, Support>> getsupport() async {
    try {
      final response = await apiService.get(ApiRoutes.support);
      final model = Support.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
