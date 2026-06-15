import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/get_bank_model.dart';
import 'package:maxpay/core/data/model/get_kyc_model.dart';
import 'package:maxpay/core/domain/repository/get_bank_repository.dart';
import 'package:maxpay/core/domain/repository/get_kyc_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class GetKycRepoImpl implements GetKycRepository {
  final ApiService apiService;
  GetKycRepoImpl(this.apiService);

  @override
  Future<Either<Failure, GetKyc>> getkyc() async {
    try {
      final response = await apiService.get(ApiRoutes.getkyc);
      final model = GetKyc.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
