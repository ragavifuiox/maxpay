

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/cash_back_model.dart';
import 'package:maxpay/core/domain/repository/cash_back_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class CashBackRepoImpl implements CashBackRepository {
  final ApiService apiService;
  CashBackRepoImpl(this.apiService);
  @override
  Future<Either<Failure, CashBack>>  cashback({
    required String producttype,
  }) async {
    try {
      final response = await apiService.get(
        ApiRoutes.cashback + producttype,
      );
      final model = CashBack.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
