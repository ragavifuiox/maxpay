import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/transaction_report_model.dart';
import 'package:maxpay/core/data/model/wallet_credit_model.dart';
import 'package:maxpay/core/domain/repository/trans_report_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_bal_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_credit_search_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class WalletCreditSearchRepoImpl implements WalletCreditSearchRepository {
  final ApiService apiService;

  WalletCreditSearchRepoImpl(this.apiService);

  @override
  Future<Either<Failure, CreditList>> searchcredit({
    required String credit,
   
    required String fromdate,
    required String todate,
    required String search,
  }) async {
    try {
      final response = await apiService.post(
        ApiRoutes.searchcredit,
        data: {
          "wallet_type": credit,
           "from_date": fromdate, 
           "to_date": todate,
           "search": search,
         
           
           },
      );

    AppLogger.debugPrint("RAW RESPONSE:");
AppLogger.debugPrint(response);

      final model = CreditList.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
