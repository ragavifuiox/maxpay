import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/today_trnasaction_model.dart';
import 'package:maxpay/core/domain/repository/today_trnsaction_repsoitory.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class TodayTransactionRepoImppl implements TodayTrnsactionRepsoitory {
  final ApiService apiService;
  TodayTransactionRepoImppl(this.apiService);

  @override
  Future<Either<Failure, TodayTransaction>> todaytrans() async {
    try {
      final response = await apiService.get(ApiRoutes.todaytrnas);
      final model = TodayTransaction.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
  
}
