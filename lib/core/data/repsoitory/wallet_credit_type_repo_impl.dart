import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/wallet_balance.dart';
import 'package:maxpay/core/data/model/wallet_credit_type_model..dart';
import 'package:maxpay/core/domain/repository/wallet_bal_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_credit_type_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class WalletCreditTypeRepoImpl implements WalletCreditTypeRepository {
  final ApiService apiService;
  WalletCreditTypeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, CreditType>> gredittype() async {
    try {
      final response = await apiService.get(ApiRoutes.Credittype);
      final model = CreditType.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
