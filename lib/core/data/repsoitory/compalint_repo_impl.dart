import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/compalints_model.dart';
import 'package:maxpay/core/data/model/news_model.dart';
import 'package:maxpay/core/data/model/wallet_balance.dart';
import 'package:maxpay/core/domain/repository/compalints_repository.dart';
import 'package:maxpay/core/domain/repository/news_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_bal_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class ComplaintsRepoImpl implements ComplaintsRepository {
  final ApiService apiService;
  ComplaintsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, Complaints>> complaints() async {
    try {
      final response = await apiService.get(ApiRoutes.complaints);
      final model = Complaints.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
