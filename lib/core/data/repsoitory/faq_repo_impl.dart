import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/earnings_mdoel.dart';
import 'package:maxpay/core/data/model/faq_model.dart';
import 'package:maxpay/core/domain/repository/earning_repository.dart';
import 'package:maxpay/core/domain/repository/faq_repsoitory.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class FaqRepoImpl implements FaqRepsoitory {
  final ApiService apiService;
  FaqRepoImpl(this.apiService);

  @override
  Future<Either<Failure, Faq>> getfaq() async {
    try {
      final response = await apiService.get(ApiRoutes.faq);
      final model = Faq.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
