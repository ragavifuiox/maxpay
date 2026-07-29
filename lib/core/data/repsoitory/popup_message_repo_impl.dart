import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/popup_message_mode.dart';
import 'package:maxpay/core/domain/repository/popup_message_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class PopupMessageRepoImpl implements PopupMessageRepository {
  final ApiService apiService;
  PopupMessageRepoImpl(this.apiService);

  @override
  Future<Either<Failure, PopupMessage>> getPopupMessage() async {
    try {
      final response = await apiService.get(ApiRoutes.popupMessage);
      final model = PopupMessage.fromJson(response);
      return Right(model);
    } on DioException catch (e) {
      AppLogger.logError("Api ${ApiRoutes.popupMessage}${e.response?.data}");
      return Left(
        ServerFailure(
          message:
              e.response?.data['message'].toString() ?? 'Unknwon Error occured',
        ),
      );
    } catch (e) {
      AppLogger.logError("Api ${ApiRoutes.popupMessage}$e");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
