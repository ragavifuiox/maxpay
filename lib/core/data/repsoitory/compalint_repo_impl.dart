// import 'package:dartz/dartz.dart';
// import 'package:maxpay/core/constants/api_routes.dart';
// import 'package:maxpay/core/data/model/compalints_model.dart';
// import 'package:maxpay/core/domain/repository/compalints_repository.dart';
// import 'package:maxpay/core/error/failure.dart';
// import 'package:maxpay/core/services/api_services.dart';


// class ComplaintsRepoImpl implements ComplaintsRepository {
//   final ApiService apiService;
//   ComplaintsRepoImpl(this.apiService);

//   @override
//   Future<Either<Failure, Complaints>> complaints() async {
//     try {
//       final response = await apiService.get(ApiRoutes.complaints);
//       final model = Complaints.fromJson(response);
//       return Right(model);
//     } catch (e) {
//       return Left(ServerFailure(message: e.toString()));
//     }
//   }
// }



import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/compalints_model.dart';
import 'package:maxpay/core/domain/repository/compalints_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/service/dio_error_handler.dart';

class ComplaintsRepoImpl implements ComplaintsRepository {
  final ApiService apiService;

  ComplaintsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, Complaints>> complaints() async {
    try {
      final response = await apiService.get(ApiRoutes.complaints);
      final model = Complaints.fromJson(response);
      return Right(model);
    } on DioException catch (e) {
      return Left(DioErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}