import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/earnings_mdoel.dart';
import 'package:maxpay/core/data/model/news_model.dart';
import 'package:maxpay/core/data/model/wallet_balance.dart';
import 'package:maxpay/core/domain/repository/earning_repository.dart';
import 'package:maxpay/core/domain/repository/news_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_bal_repository.dart';
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
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
