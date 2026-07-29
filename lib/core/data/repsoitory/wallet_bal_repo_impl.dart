import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/wallet_balance.dart';
import 'package:maxpay/core/domain/repository/wallet_bal_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';


class WalletBalanceRepoImpl implements WalletBalanceRepository {
  final ApiService apiService;
  WalletBalanceRepoImpl(this.apiService);

  @override
  Future<Either<Failure, WalletBalance>> getWalletBalance() async {
    try {
      final response = await apiService.get(ApiRoutes.walletbalance);
      final model = WalletBalance.fromJson(response);
      return Right(model);
    } catch (e) {
        AppLogger.logError("Api ${ApiRoutes.walletbalance}$e");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
