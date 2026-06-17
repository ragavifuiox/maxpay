import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/dth_tab_model.dart';
import 'package:maxpay/core/domain/repository/dth_tab_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class DthTabUsecase {
  final DthTabRepository repository;
  DthTabUsecase(this.repository);
  Future<Either<Failure, DthTab>> call() {
    return repository.getdthplan();
  }
}
