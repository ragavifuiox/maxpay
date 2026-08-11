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
//     } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
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
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/service/dio_error_handler.dart';

class TodayCreditRepoImpl implements TodayCreditRepository {
  final ApiService apiService;

  TodayCreditRepoImpl(this.apiService);

  @override
  Future<Either<Failure, TodayCredit>> todaycredit() async {
    try {
      final response = await apiService.get(ApiRoutes.todaycredit);
      final model = TodayCredit.fromJson(response);
      return Right(model);
    } on DioException catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(DioErrorHandler.handle(e));
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
    AppLogger.logError("Api ${ApiRoutes.todaycredit}$e");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
