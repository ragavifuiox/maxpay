import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:maxpay/core/constants/api_urls.dart';

import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/services/local_storage_service.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/core/utils/snackbar.dart';

class ApiService {
  final Dio _dio;
  final _storage = LocalStorageService();
  final bool _isUnauthorizedHandled = false;

  ApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiUrls.baseUrl,
          // connectTimeout: const Duration(seconds: 10),
          // receiveTimeout: const Duration(seconds: 10),
          contentType: 'application/json',
          headers: {
            "Accept": "application/json",
            "x-api-key": "mnbvcxzasdfghjklpoiuytrewqzxcvbnm",
          },
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _storage.getString("auth_token");
          AppLogger.logError("TOKEN: $token");
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
        // onRequest: (options, handler) {
        //   final token = _storage.getString("auth_token");
        //   if (token != null) {
        //     options.headers["Authorization"] = "Bearer $token";
        //   }
        //   return handler.next(options);
        // },
        // onError: (DioException e, handler) {
        //   log("API Error: ${e.message}");
        //   final statusCode = e.response?.statusCode;

        //   if (statusCode == 401) {
        //     _handleUnauthorized();
        //   } else {
        //     print( "asdfasdfasdf"+e.response?.data?['message'] ?? "Something went wrong");
        //     g.Get.snackbar(
        //       "Error",
        //       e.response?.data?['message'] ?? "Something went wrong",
        //     );
        //   }

        //   return handler.next(e);
        // },
        onError: (DioException e, handler) {
          print("FAILED URL => ${e.requestOptions.uri}");
          print("STATUS => ${e.response?.statusCode}");
          print("TOKEN => ${_storage.getString("auth_token")}");
          log("API Error: ${e.message}");

          // ✅ If NO INTERNET → go to network screen ONLY

          // ✅ Only handle 401 if internet is available
          if (e.response?.statusCode == 401) {
            // _handleUnauthorized();
          } else {
            // g.Get.snackbar(
            //   "Error",
            //   e.response?.data?['message'] ?? "Something went wrong",
            // );
            AppLogger.logError(
              e.response?.data?['message'] ?? "Something went wrong",
            );
          }

          return handler.next(e);
        },
      ),
    );
  }

  Future<Map<String, dynamic>> post(String endpoint, {dynamic data}) async {
    return _handleResponse(
      () => _dio.post(
        endpoint,
        data: data,
        options: Options(
          contentType: data is FormData ? null : 'application/json',
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? params,
  }) async {
    AppLogger.debugPrint(endpoint);
    return _handleResponse(() => _dio.get(endpoint, queryParameters: params));
  }

  Future<Map<String, dynamic>> put(
    String endpoint, {
    dynamic data,
    bool useFormData = false,
  }) async {
    return _handleResponse(
      () => _dio.put(
        endpoint,
        data: useFormData && data is Map
            ? FormData.fromMap(Map<String, dynamic>.from(data))
            : data,
        options: Options(contentType: useFormData ? null : 'application/json'),
      ),
    );
  }

  Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    return _handleResponse(() => _dio.delete(endpoint, data: data));
  }

  Future<Map<String, dynamic>> _handleResponse(
    Future<Response> Function() request,
  ) async {
    try {
      final response = await request();

      // ✅ Safely convert to Map<String, dynamic>
      if (response.data is Map) {
        return Map<String, dynamic>.from(
          response.data as Map<dynamic, dynamic>,
        );
      }

      // If response is not a map (e.g., List or String)
      return {"data": response.data};
    } on DioException catch (e) {
      log("DioException: ${e.requestOptions.path}  ${e.message}");
      rethrow;
    } catch (e) {
      log("Unknown error: $e");
      throw Exception("Unexpected error occurred");
    }
  }

  // void _handleUnauthorized() {
  //   _storage.remove("auth_token");
  //   g.Get.offAllNamed(AppRoutes.login);

  //   g.Get.snackbar("Session Expired", "Please login again.");
  // }

  void _handleUnauthorized() {
    final token = _storage.getString("auth_token");

    // Fresh install / logged out user
    if (token == null || token.isEmpty) {
      return;
    }

    _storage.remove("auth_token");

    g.Get.offAllNamed(AppRoutes.welcome);
    CustomToast.error("Session Expired,\nPlease login again.");
  }

  // void _handleUnauthorized() {
  //   if (_isUnauthorizedHandled) return;
  //   _isUnauthorizedHandled = true;

  //   _storage.remove("auth_token");

  //   g.Get.offAllNamed(AppRoutes.welcome);

  //   g.Get.snackbar("Session Expired", "Please login again.");
  // }
}
