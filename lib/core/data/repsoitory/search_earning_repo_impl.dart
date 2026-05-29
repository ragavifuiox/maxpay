import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/create_pin_model.dart';
import 'package:maxpay/core/data/model/login_model.dart';
import 'package:maxpay/core/data/model/otp_response_model.dart';
import 'package:maxpay/core/data/model/search_earnings_model.dart';
import 'package:maxpay/core/domain/repository/create_pin_repository.dart';
import 'package:maxpay/core/domain/repository/login_repository.dart';
import 'package:maxpay/core/domain/repository/otp_repository.dart';
import 'package:maxpay/core/domain/repository/search_earnings_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class SearchEarningsRepoImpl implements SearchEarningsRepository {
  final ApiService apiService;

  SearchEarningsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, SearchEarnings>> searchEarnings({
    required String fromdate,
    required String todate,
  }) async {
    try {
     final response = await apiService.post(
        ApiRoutes.searchearnings,
        data: {
          "from_date": fromdate,
          "to_date": todate,
        },
      );

      final model = SearchEarnings.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

        