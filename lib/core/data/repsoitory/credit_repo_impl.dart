import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/gredit_model.dart';
import 'package:maxpay/core/domain/repository/credit_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class CreditRepoImpl implements CreditRepository {
  final ApiService apiService;
  CreditRepoImpl(this.apiService);

  @override
  Future<Either<Failure, Credit>> getCredit() async {
    try {
      final response = await apiService.get(ApiRoutes.credit);
      final model = Credit.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

