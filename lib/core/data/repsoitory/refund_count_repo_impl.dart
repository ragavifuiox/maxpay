// import 'package:dartz/dartz.dart';
// import 'package:maxpay/core/constants/api_routes.dart';
// import 'package:maxpay/core/data/model/refund_count_model.dart';
// import 'package:maxpay/core/domain/repository/refund_count_repository.dart';
// import 'package:maxpay/core/error/failure.dart';
// import 'package:maxpay/core/services/api_services.dart';


// class RefundCountRepoImpl implements RefundCountRepository {
//   final ApiService apiService;
//   RefundCountRepoImpl(this.apiService);

//   @override
//   Future<Either<Failure, RefundCount>> refundcount() async {
//     try {
//       final response = await apiService.get(ApiRoutes.refundcount);
//       final model = RefundCount.fromJson(response);
//       return Right(model);
//     } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
//       return Left(ServerFailure(message: e.toString()));
//     }
//   }
// }



import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/refund_count_model.dart';
import 'package:maxpay/core/domain/repository/refund_count_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/service/dio_error_handler.dart';

class RefundCountRepoImpl implements RefundCountRepository {
  final ApiService apiService;

  RefundCountRepoImpl(this.apiService);

  @override
  Future<Either<Failure, RefundCount>> refundcount() async {
    try {
      final response = await apiService.get(ApiRoutes.refundcount);
      final model = RefundCount.fromJson(response);
      return Right(model);
    } on DioException catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(DioErrorHandler.handle(e));
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      AppLogger.logError("Api ${ApiRoutes.refundcount}$e");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
