import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/search_staff_model.dart';
import 'package:maxpay/core/domain/repository/search_staff_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class SearchStaffRepoImpl implements SearchStaffRepository {
  final ApiService apiService;

  SearchStaffRepoImpl(this.apiService);

  @override
  Future<Either<Failure, SearchStaff>> searchStaff({
    required String mobile,
  }) async {
    try {
    final response = await apiService.post(
  ApiRoutes.searchstaff,
  data: {
    "mobile": mobile,
  },
);

  

AppLogger.logError("=========== 👍REQUEST BODY ===========");
AppLogger.logError({
  "mobile": mobile,
});

AppLogger.logError("=========== 👍RAW RESPONSE ===========");
AppLogger.logError(response);
AppLogger.logError("====================================");
      final model = SearchStaff.fromJson(response);
      return Right(model);
    } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


    
