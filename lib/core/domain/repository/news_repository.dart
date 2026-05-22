import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/news_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class GetNewsRepository {
  Future<Either<Failure, News>> getNews();
}
