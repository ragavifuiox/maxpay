import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/graph_model.dart';

import 'package:maxpay/core/domain/repository/graph_repository.dart';

import 'package:maxpay/core/error/failure.dart';



class GraphUsecase {
  final GraphRepository repository;
  GraphUsecase(this.repository);
  Future<Either<Failure, Graph>> call() {
    return repository.graph();
  }
}
