

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/search_staff_model.dart';
import 'package:maxpay/core/domain/repository/search_staff_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class SearchStaffUsecase  {
  final SearchStaffRepository repository;
  SearchStaffUsecase(this.repository);
  Future<Either<Failure, SearchStaff>> call(
    String mobile,
  ) {
    return repository.searchStaff(
      mobile: mobile,
    );
  }
}

 
