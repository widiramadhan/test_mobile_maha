class UsersEntity {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<DataEntity>? data;
  SupportEntity? support;

  UsersEntity({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsersEntity &&
        other.page == page &&
        other.perPage == perPage &&
        other.total == total &&
        other.totalPages == totalPages &&
        other.data == data &&
        other.support == support;
  }

  @override
  int get hashCode {
    return page.hashCode ^
    perPage.hashCode ^
    total.hashCode ^
    totalPages.hashCode ^
    data.hashCode ^
    support.hashCode;
  }

  @override
  String toString() {
    return 'UsersEntity(page: $page, perPage: $perPage, total: $total, totalPages: $totalPages, data: $data, support: $support)';
  }
}

class DataEntity {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  DataEntity({required this.id, required this.email, required this.firstName, required this.lastName, required this.avatar});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DataEntity &&
        other.id == id &&
        other.email == email &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    email.hashCode ^
    firstName.hashCode ^
    lastName.hashCode ^
    avatar.hashCode;
  }

  @override
  String toString() {
    return 'Data(id: $id, email: $email, firstName: $firstName, lastName: $lastName, avatar: $avatar)';
  }
}

class SupportEntity {
  String? url;
  String? text;

  SupportEntity({required this.url, required this.text});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SupportEntity &&
        other.url == url &&
        other.text == text;
  }

  @override
  int get hashCode {
    return url.hashCode ^
    text.hashCode;
  }

  @override
  String toString() {
    return 'Support(url: $url, text: $text)';
  }
}
