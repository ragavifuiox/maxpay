import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/news_model.dart';
import 'package:maxpay/core/domain/repository/news_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class GetNewsUseCase {
  final GetNewsRepository repository;
  GetNewsUseCase(this.repository);
  Future<Either<Failure, News>> call() {
    return repository.getNews();
  }
}
