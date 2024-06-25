import 'package:test_it_maha/core/state/data_state/data_state.dart';
import 'package:test_it_maha/data/model/request/users_req.dart';
import 'package:test_it_maha/data/repository/users_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:test_it_maha/domain/entity/users/users_entity.dart';

@LazySingleton()
class UsersUseCase {
  final UsersRepository _repository;

  UsersUseCase(
    this._repository,
  );

  Future<DataState<UsersEntity>> call() async {
    return await _repository.getUsers();
  }

  Future<DataState> addUser({
    required UsersReq request,
  }) async {
    return await _repository.addUsers(request: request);
  }
}
