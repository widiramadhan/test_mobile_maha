import 'package:test_it_maha/core/state/data_state/data_state.dart';
import 'package:test_it_maha/data/data_source/users_remote/users_remote.dart';
import 'package:test_it_maha/data/model/request/users_req.dart';
import 'package:test_it_maha/domain/entity/users/users_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:test_it_maha/domain/mapper/users_mapper.dart';

@LazySingleton()
class UsersRepository {
  final UsersRemote _usersRemote;

  UsersRepository(this._usersRemote);

  Future<DataState<UsersEntity>> getUsers() async {
    final result = await _usersRemote.getUser();
    return result.when(
      success: (data) {
        return DataState.success(
          data: UsersMapper.mapModelToEntity(data),
        );
      },
      error: (message, code, exception, stackTrace) {
        return DataState.error(
          message: message,
          code: code,
          exception: exception,
          stackTrace: stackTrace,
        );
      },
    );
  }

  Future<DataState> addUsers({
    required UsersReq request,
  }) async {
    final result = await _usersRemote.addUser(request: request);
    return result.when(
      success: (data) {
        return DataState.success(data: null);
      },
      error: (message, code, exception, stackTrace) {
        return DataState.error(
          message: message,
          code: code,
          exception: exception,
          stackTrace: stackTrace,
        );
      },
    );
  }
}
