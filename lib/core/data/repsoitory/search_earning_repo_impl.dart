import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/my_earnings_model.dart';
import 'package:maxpay/core/domain/repository/search_earning_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class SearchEarningsRepoImpl implements SearchEarningsRepository {
  final ApiService apiService;

  SearchEarningsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, MyEarning>> searchEarnings({
    required String fromdate,
    required String todate,
    required String search,
  }) async {
    try {
     final response = await apiService.post(
        ApiRoutes.searchearnings,
        data: {
          "from_date": fromdate,
          "to_date": todate,
          "search": search,
        },
      );

      final model = MyEarning.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

        