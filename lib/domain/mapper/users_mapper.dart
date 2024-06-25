import 'package:test_it_maha/data/model/response/users/users_resp.dart';
import 'package:test_it_maha/domain/entity/users/users_entity.dart';

class UsersMapper {
  const UsersMapper._();

  static UsersEntity mapModelToEntity(UsersResp data) {
    return UsersEntity(
        page: data.page,
        perPage: data.perPage,
        total: data.total,
        totalPages: data.totalPages,
        data: data.data!
            .map((e) => DataMapper.mapModelToEntity(e))
            .toList(),
        support: SupportEntity(url: data.support?.url, text: data.support?.text));
  }

  static UsersResp mapEntityToModel(UsersEntity data) {
    return UsersResp(
        page: data.page,
        perPage: data.perPage,
        total: data.total,
        totalPages: data.totalPages,
        data: data.data!
            .map((e) => DataMapper.mapEntityToModel(e))
            .toList(),
        support: Support(url: data.support?.url, text: data.support?.text)
    );
  }
}

class DataMapper {
  const DataMapper._();

  static DataEntity mapModelToEntity(Data data) {
    return DataEntity(id: data.id, email: data.email, firstName: data.firstName, lastName: data.lastName, avatar: data.avatar);
  }

  static Data mapEntityToModel(DataEntity data) {
    return Data(id: data.id, email: data.email, firstName: data.firstName, lastName: data.lastName, avatar: data.avatar);
  }
}
