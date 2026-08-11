import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/grade_model.dart';
import 'package:maxpay/core/domain/repository/grade_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class GradeRepoImpl implements GradeRepository {
  final ApiService apiService;
  GradeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, RetailorGrade>> grade() async {
    try {
      final response = await apiService.get(ApiRoutes.grade);
      final model = RetailorGrade.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

