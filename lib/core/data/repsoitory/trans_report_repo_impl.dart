import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/transaction_report_model.dart';
import 'package:maxpay/core/domain/repository/trans_report_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class TransReportRepoImpl implements TransReportRepository {
  final ApiService apiService;

  TransReportRepoImpl(this.apiService);

  @override
  Future<Either<Failure, TransactionReport>> transreport({
    required String productid,
    required String status,
    required String fromdate,
    required String todate,
    required String search,
  }) async {
    try {
      final response = await apiService.post(
        ApiRoutes.transreport,
        data: {
          "product_type_id": productid,
           "from_date": fromdate, 
           "to_date": todate,
           "search": search,
           "status": status,
           
           },
      );

    AppLogger.debugPrint("RAW RESPONSE:");
AppLogger.debugPrint(response);

      final model = TransactionReport.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
