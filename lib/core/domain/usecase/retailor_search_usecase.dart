import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/retailer_search_model.dart';
import 'package:maxpay/core/data/model/staff_wallet_reverse_model.dart';
import 'package:maxpay/core/domain/repository/retailor_search_repository.dart';
import 'package:maxpay/core/domain/repository/staff_wallet_reverse_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class RetailorSearchUsecase {
  final RetailorSearchRepository repository;
  RetailorSearchUsecase(this.repository);
  Future<Either<Failure, RetailorSearch>> call({
    required String regmob,

  }) {
    return repository.searchretailor(
regmob: regmob,
   
    );
  }
}
