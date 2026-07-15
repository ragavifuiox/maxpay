import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/earnings_mdoel.dart';
import 'package:maxpay/core/data/model/faq_model.dart';
import 'package:maxpay/core/domain/repository/earning_repository.dart';
import 'package:maxpay/core/domain/repository/faq_repsoitory.dart';
import 'package:maxpay/core/error/failure.dart';



class FaqUsecase {
  final FaqRepsoitory repository;
  FaqUsecase(this.repository);
  Future<Either<Failure, Faq>> call() {
    return repository.getfaq();
  }
}
