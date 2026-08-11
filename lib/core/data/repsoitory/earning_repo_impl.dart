import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/earnings_mdoel.dart';
import 'package:maxpay/core/domain/repository/earning_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class EarningsRepoImpl implements EarningsRepository {
  final ApiService apiService;
  EarningsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, Earnings>> getEarnings() async {
    try {
      final response = await apiService.get(ApiRoutes.earning);
      final model = Earnings.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

