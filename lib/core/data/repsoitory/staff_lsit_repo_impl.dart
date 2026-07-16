import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/staff_lsit_model.dart';
import 'package:maxpay/core/data/model/transaction_report_model.dart';
import 'package:maxpay/core/domain/repository/staff_list_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class StaffListRepoImpl implements StaffListRepository {
  final ApiService apiService;
  StaffListRepoImpl(this.apiService);

  @override
  Future<Either<Failure, StaffList>> getStaffList() async {
    try {
      final response = await apiService.get(ApiRoutes.stafflist);
      final model = StaffList.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TransactionReport>> getStaffTransactionReport(
    String? prdId,
    String? fromDate,
    String? toDate,
    String? search,
    String? status,
  ) async {
    try {
      final response = await apiService.post(
        ApiRoutes.stafftransactionreport,
        data: {
          "product_id": prdId,
          "fromdate": fromDate,
          "todate": toDate,
          "search": search,
          "status": status,
        },
      );
      final model = TransactionReport.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
