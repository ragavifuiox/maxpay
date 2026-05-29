import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/news_model.dart';
import 'package:maxpay/core/data/model/popup_message_mode.dart';
import 'package:maxpay/core/data/model/wallet_balance.dart';
import 'package:maxpay/core/domain/repository/news_repository.dart';
import 'package:maxpay/core/domain/repository/popup_message_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_bal_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';


class PopupMessageRepoImpl implements PopupMessageRepository {
  final ApiService apiService;
  PopupMessageRepoImpl(this.apiService);

  @override
  Future<Either<Failure, PopupMessage>> getPopupMessage() async {
    try {
      final response = await apiService.get(ApiRoutes.popupMessage);
      final model = PopupMessage.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
