import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/statement_model.dart';
import 'package:maxpay/core/data/model/transaction_report_model.dart';
import 'package:maxpay/core/data/model/wallet_credit_model.dart';
import 'package:maxpay/core/data/model/wallet_report_model.dart';
import 'package:maxpay/core/domain/repository/statement_repository.dart';
import 'package:maxpay/core/domain/repository/trans_report_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_bal_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_credit_search_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_report_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class StatementRepoImpl implements StatementRepository {
  final ApiService apiService;

  StatementRepoImpl(this.apiService);

  @override
  Future<Either<Failure, Statement>> statement({
    required String type,
   
    required String fromdate,
    required String todate,
    required String search,
  }) async {
    try {
      final response = await apiService.post(
        ApiRoutes.statement,
        data: {
          "type": type,
           "from_date": fromdate, 
           "to_date": todate,
           "search": search,
         
           
           },
      );


AppLogger.debugPrint({
  "type": type,
  "from_date": fromdate,
  "to_date": todate,
  "search": search,
});
    AppLogger.debugPrint("RAW RESPONSE:");
AppLogger.debugPrint(response);

      final model = Statement.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
