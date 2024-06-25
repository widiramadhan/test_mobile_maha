import 'dart:async';

import 'package:dio/dio.dart';
import 'package:test_it_maha/core/service/network_service.dart';
import 'package:test_it_maha/core/state/data_state/data_state.dart';
import 'package:test_it_maha/data/constants/api_path.dart';
import 'package:injectable/injectable.dart';
import 'package:test_it_maha/data/model/request/users_req.dart';
import 'package:test_it_maha/data/model/response/users/users_resp.dart';

@LazySingleton()
class UsersRemote {
  final NetworkService _service;

  UsersRemote(this._service);

  Future<DataState<UsersResp>> getUser() async {
    try {
      final response = await _service.setFormUrlEncodedContentType().call.get(
        ApiPath.USERS,
      );
      if (response.data != null && response.statusCode == 200) {
        final result = UsersResp.fromJson(response.data);
        return DataState.success(data: result);
      }
      return DataState.error(message: "Something wrong");
    } on DioError catch (e) {
      if (e.response?.data is Map) {
        return DataState.error(
          exception: e,
          stackTrace: e.stackTrace,
          message: e.response?.data['message'] ?? "Error",
          code: e.response?.statusCode ?? -1,
        );
      }
      return DataState.error(
        exception: e,
        stackTrace: e.stackTrace,
        message: e.response?.statusMessage ?? "Failed",
        code: e.response?.statusCode ?? -1,
      );
    } on TimeoutException catch (e, stack) {
      return DataState.error(
        exception: e,
        stackTrace: stack,
        message: '${e.message}: Has been trying for ${e.duration}',
      );
    } on Exception catch (e, stack) {
      return DataState.error(
        message: 'Unhandled Error',
        exception: e,
        stackTrace: stack,
      );
    }
  }

  Future<DataState> addUser({
    required UsersReq request,
  }) async {
    try {
      final response = await _service.call.post(
          ApiPath.USERS,
          data: request.toJson(),
      );
      return DataState.success(data: null);
    } on DioError catch (e) {
      if (e.response?.data is Map) {
        return DataState.error(
          exception: e,
          stackTrace: e.stackTrace,
          message: e.response?.data['message'] ?? "Error",
          code: e.response?.statusCode ?? -1,
        );
      }
      return DataState.error(
        exception: e,
        stackTrace: e.stackTrace,
        message: e.response?.statusMessage ?? "Failed",
        code: e.response?.statusCode ?? -1,
      );
    } on TimeoutException catch (e, stack) {
      return DataState.error(
        exception: e,
        stackTrace: stack,
        message: '${e.message}: Has been trying for ${e.duration}',
      );
    } on Exception catch (e, stack) {
      return DataState.error(
        message: 'Unhandled Error',
        exception: e,
        stackTrace: stack,
      );
    }
  }
}
