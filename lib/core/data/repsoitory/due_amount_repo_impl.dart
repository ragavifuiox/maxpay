import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/due_amount_model.dart';
import 'package:maxpay/core/domain/repository/due_amount_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';


class DueAmountRepoImpl implements DueAmountRepository {
  final ApiService apiService;
  DueAmountRepoImpl(this.apiService);

  @override
  Future<Either<Failure, DueAmount>> Dueamount() async {
    try {
      final response = await apiService.get(ApiRoutes.dueamount);
      final model = DueAmount.fromJson(response);
      return Right(model);
    } catch (e) {
      AppLogger.logError("Api ${ApiRoutes.dueamount} $e");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
