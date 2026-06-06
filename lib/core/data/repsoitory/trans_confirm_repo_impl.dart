import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/trans_confirm_model.dart';
import 'package:maxpay/core/domain/repository/trans_confirm_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class TransConfirmRepoImpl implements TransConfirmRepository {
  final ApiService apiService;
  TransConfirmRepoImpl(this.apiService);
  @override
  Future<Either<Failure, TransConfirm>> getTransactionConfirm({
    required String prodcutdetid,

  }) async {
    print(prodcutdetid);
    try {
      final response = await apiService.get(
       "${ApiRoutes.TransactionConfirm}$prodcutdetid"
      );
final decoded = response;

Map<String, dynamic> jsonMap;

if (decoded is List) {
  jsonMap = decoded.isNotEmpty
      ? Map<String, dynamic>.from(decoded[0])
      : {};
} else {jsonMap = decoded;}


final model = TransConfirm.fromJson(jsonMap);
return Right(model);
      
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}