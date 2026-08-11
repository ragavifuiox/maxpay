import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/wallet_report_model.dart';
import 'package:maxpay/core/domain/repository/wallet_report_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class WalletReportRepoImpl implements WalletReportRepository {
  final ApiService apiService;

  WalletReportRepoImpl(this.apiService);

  @override
  Future<Either<Failure, WalletReport>> walletreport({
    required String paymenttype,
   
    required String fromdate,
    required String todate,
    required String search,
  }) async {
    try {
      final response = await apiService.post(
        ApiRoutes.walletreport,
        data: {
          "payment_type": paymenttype,
           "from_date": fromdate, 
           "to_date": todate,
           "search": search,
         
           
           },
      );


AppLogger.debugPrint({
  "wallet_type": paymenttype,
  "from_date": fromdate,
  "to_date": todate,
  "search": search,
});
    AppLogger.debugPrint("RAW RESPONSE:");
AppLogger.debugPrint(response);

      final model = WalletReport.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

