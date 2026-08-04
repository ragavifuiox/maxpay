import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/wallet_credit_model.dart';
import 'package:maxpay/core/domain/repository/wallet_credit_search_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/service/dio_error_handler.dart';

class WalletCreditSearchRepoImpl implements WalletCreditSearchRepository {
  final ApiService apiService;

  WalletCreditSearchRepoImpl(this.apiService);

  @override
  Future<Either<Failure, CreditListModel>> searchcredit({
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

      final model = CreditListModel.fromJson(response);
      return Right(model);
    } on DioException catch (e) {
      return Left(DioErrorHandler.handle(e));
    } catch (e) {
      AppLogger.logError("Unexpected Error: $e");
      return Left(ServerFailure(message: "Something went wrong"));
    }
  }
}
