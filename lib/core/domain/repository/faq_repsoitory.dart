import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/faq_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class FaqRepsoitory {
  Future<Either<Failure, Faq>> getfaq();
}
