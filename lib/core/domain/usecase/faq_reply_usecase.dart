import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/download_model.dart';
import 'package:maxpay/core/data/model/faq_reply_model.dart';

import 'package:maxpay/core/domain/repository/downlaod_repository.dart';
import 'package:maxpay/core/domain/repository/faq_reply_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class FaqReplyUsecase {
  final FaqReplyRepository repository;
  FaqReplyUsecase(this.repository);
  Future<Either<Failure, FaqReply>> call({
    required String faqid,
      required comment ,
      required String reply,
    }) {
    return repository.faqreply(
      faqid: faqid,
      comment: comment,
      reply: reply
      );
  }
}
