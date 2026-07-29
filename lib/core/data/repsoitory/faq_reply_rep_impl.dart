import 'package:dartz/dartz.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/faq_reply_model.dart';
import 'package:maxpay/core/domain/repository/faq_reply_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class FaqReplyRepImpl implements FaqReplyRepository {
  final ApiService apiService;

  FaqReplyRepImpl(this.apiService);

  @override
  Future<Either<Failure, FaqReply>> faqreply({
    required String faqid,
    required String comment,
    required String reply,
  }) async {
    try {
    final response = await apiService.post(
  ApiRoutes.addstaff,
  data: {
    "faq_id": faqid,
    "comment": comment,
    "reply": reply,
  },
);

AppLogger.logError("=========== 👍REQUEST BODY ===========");
AppLogger.logError({
  "faq_id": faqid,
    "comment": comment,
    "reply": reply,
});

AppLogger.logError("=========== 👍RAW RESPONSE ===========");
AppLogger.logError(response);
AppLogger.logError("====================================");
      final model = FaqReply.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


    