// import 'package:dartz/dartz.dart';
// import 'package:maxpay/core/constants/api_routes.dart';
// import 'package:maxpay/core/data/model/today_credit_model.dart';
// import 'package:maxpay/core/domain/repository/today_credit_repository.dart';
// import 'package:maxpay/core/error/failure.dart';
// import 'package:maxpay/core/services/api_services.dart';


// class TodayCreditRepoImpl implements TodayCreditRepository {
//   final ApiService apiService;
//   TodayCreditRepoImpl(this.apiService);

//   @override
//   Future<Either<Failure, TodayCredit>> todaycredit() async {
//     try {
//       final response = await apiService.get(ApiRoutes.todaycredit);
//       final model = TodayCredit.fromJson(response);
//       return Right(model);
//     } catch (e) {
//       return Left(ServerFailure(message: e.toString()));
//     }
//   }
// }



import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/today_credit_model.dart';
import 'package:maxpay/core/domain/repository/today_credit_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class TodayCreditRepoImpl implements TodayCreditRepository {
  final ApiService apiService;

  TodayCreditRepoImpl(this.apiService);

  @override
  Future<Either<Failure, TodayCredit>> todaycredit() async {
    try {
      final response = await apiService.get(ApiRoutes.todaycredit);
      final model = TodayCredit.fromJson(response);
      return Right(model);
    } on DioException catch (e) {
      String message = "Something went wrong";

      if (e.response?.data is Map<String, dynamic>) {
        message = e.response?.data["message"] ?? message;
      } else if (e.response?.data != null) {
        message = e.response!.data.toString();
      } else {
        message = e.message ?? message;
      }

      return Left(ServerFailure(message: message));
    } catch (e) {
    AppLogger.logError("Api ${ApiRoutes.todaycredit}" + e.toString());
      return Left(ServerFailure(message: e.toString()));
    }
  }
}