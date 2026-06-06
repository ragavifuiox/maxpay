import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/login_model.dart';
import 'package:maxpay/core/domain/repository/login_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class LoginRepositoryImpl implements LoginRepository {
  final ApiService apiService;

  LoginRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, Login>> login({
    required String phoneNumber,
    required String name,
    required String pincode,
    required String countrycode,
  }) async {
    try {
      final response = await apiService.post(
        ApiRoutes.login,
        data: FormData.fromMap({
          "phone_number": phoneNumber,
          "pincode": pincode,
          "name": name,
          "country_code": countrycode.replaceAll("+", ""),
        }),
      );

      final model = Login.fromJson(response);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String,dynamic>>> logout() async {
    try {
      final response = await apiService.post(ApiRoutes.logout);

      if (response['success'] == true) {
        return Right(response);
      } else {
        return Left(AuthFailure(response['message']));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.response?.data['message']));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
