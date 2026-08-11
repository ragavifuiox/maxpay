import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/get_bank_model.dart';
import 'package:maxpay/core/domain/repository/get_bank_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class GetBankRepoImpl implements GetBankRepository {
  final ApiService apiService;
  GetBankRepoImpl(this.apiService);

  @override
  Future<Either<Failure, Bank>> getbank() async {
    try {
      final response = await apiService.get(ApiRoutes.bank);
      final model = Bank.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

