import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';

import 'package:maxpay/core/data/model/total_trnsaction.dart';
import 'package:maxpay/core/domain/repository/total_transaction_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class TotalTransactionRepoImppl implements TotalTransactionRepsoitory {
  final ApiService apiService;
  TotalTransactionRepoImppl(this.apiService);

  @override
  Future<Either<Failure, TotalTransaction>> totaltrans() async {
    try {
      final response = await apiService.get(ApiRoutes.totalrecharge);
      final model = TotalTransaction.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
  
}
