

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/search_dth_model.dart';
import 'package:maxpay/core/data/model/search_plan_model.dart';
import 'package:maxpay/core/domain/repository/search_dth_repository.dart';
import 'package:maxpay/core/domain/repository/search_plan_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class SearchDthUsecase  {
  final SearchDthRepository repository;
  SearchDthUsecase(this.repository);
  Future<Either<Failure, SearchDth>> searchdth(
    String planid,
    String amount,
  ) {
    return repository.searchdth(
      planid: planid,
      amount: amount,
    );
  }
}
