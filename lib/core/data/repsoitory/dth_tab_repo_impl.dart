import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/dth_tab_model.dart';
import 'package:maxpay/core/domain/repository/dth_tab_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class DthTabRepoImpl implements DthTabRepository {
  final ApiService apiService;
  DthTabRepoImpl(this.apiService);

  @override
Future<Either<Failure, DthTab>> getdthplan() async {
  try {
    print("DTH TAB URL => ${ApiRoutes.dthtab}");

    final response = await apiService.get(ApiRoutes.dthtab);

    print("DTH TAB RESPONSE => $response");

    final model = DthTab.fromJson(response);

    return Right(model);
  } catch (e, stackTrace) { print("API EXCEPTION IN REPO: `$e\n`$stackTrace");
    print("DTH TAB ERROR => $e");

    return Left(ServerFailure(message: e.toString()));
  }
}
}

