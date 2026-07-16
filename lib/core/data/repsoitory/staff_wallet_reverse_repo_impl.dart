import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/staff_wallet_reverse_model.dart';
import 'package:maxpay/core/data/model/statement_model.dart';
import 'package:maxpay/core/domain/repository/staff_wallet_reverse_repository.dart';
import 'package:maxpay/core/domain/repository/statement_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class StaffWalletReverseRepoImpl implements StaffWalletReverseRepository {
  final ApiService apiService;

  StaffWalletReverseRepoImpl(this.apiService);

  @override
  Future<Either<Failure, StaffReverse>> staffreverse({
    required String id,
   
   
  }) async {
    try {
      final response = await apiService.post(
        ApiRoutes.staffwalletreverse,
        data: {
          "id": id,
          
           
           },
      );


AppLogger.debugPrint({
  "id": id,
  
});
    AppLogger.debugPrint("RAW RESPONSE:");
AppLogger.debugPrint(response);

      final model = StaffReverse.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
