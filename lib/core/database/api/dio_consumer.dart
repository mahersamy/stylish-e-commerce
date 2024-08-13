

import 'package:dio/dio.dart';

import '../../errors/error_model.dart';
import '../../errors/exceptions.dart';
import 'api_consumer.dart';
import 'end_points.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      Response response =
          await dio.get(path, data: data, queryParameters: queryParameters);
      return response.data!;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        bool isFormData=false,
      }) async {
    try {
      Response response = await dio.post(
        path,
        data: isFormData? FormData.fromMap(data):data,
        queryParameters: queryParameters,
      );
      return response.data;

    } on DioException catch (e) {
      handleDioException(e);
    }
  }


  @override
  Future patch(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      Response response =
          await dio.patch(path, data: data, queryParameters: queryParameters);
      return response.data!;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future delete(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      Response response =
          await dio.delete(path, data: data, queryParameters: queryParameters);
      return response.data!;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  handleDioException(e) {
    switch (e.type) {
      case DioExceptionType.badCertificate:
        throw BadCertificateException(ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.connectionTimeout:
        throw ConnectionTimeoutException(ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.sendTimeout:
        throw ServerException(ErrorModel.fromJson(e.response!.data));

      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 400: //bad request
            throw BadRequestException(ErrorModel.fromJson(e.response!.data));

          case 401: //unauthorized
            throw UnauthorizedException(ErrorModel.fromJson(e.response!.data));

          case 403: //forbidden
            throw ForbiddenException(ErrorModel.fromJson(e.response!.data));

          case 404: //notFound
            throw NotFoundException(ErrorModel.fromJson(e.response!.data));

          case 409: //conflict
            throw ConflictException(ErrorModel.fromJson(e.response!.data));
          case 504:
            throw BadRequestException(ErrorModel.fromJson(e.response!.data));

          // print(e.response);
        }
      case DioExceptionType.cancel:
        throw ServerException(
            ErrorModel(status: 500, errorMessage: e.toString()));

      case DioExceptionType.unknown:
        throw ServerException(
            ErrorModel(status: 500, errorMessage: e.toString()));

      // throw ServerException('badResponse');
    }
  }
}
