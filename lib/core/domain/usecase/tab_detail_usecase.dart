import 'package:dartz/dartz.dart';

import 'package:maxpay/core/data/model/tab_detail.dart';
import 'package:maxpay/core/domain/repository/tab_detail_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class TabDetailUsecase {
  final TabDetailRepository repository;
  TabDetailUsecase(this.repository,);
  Future<Either<Failure, TabDetail>> call({required String tabid}) {
    return repository.gettabdetail(tabid: tabid);
  }
}
