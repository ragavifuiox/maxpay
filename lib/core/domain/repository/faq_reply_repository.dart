import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/faq_reply_model.dart';

import 'package:maxpay/core/error/failure.dart';



abstract class FaqReplyRepository {
  Future<Either<Failure, FaqReply>> faqreply({
    required String faqid,
    required String comment,
    required String reply,
  });
}
