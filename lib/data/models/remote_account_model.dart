import 'package:tdd_clean_patterns_solid/data/http/http.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/account_entity.dart';

class RemoteAccountModel {
  final String accessToken;

  RemoteAccountModel(this.accessToken);

  factory RemoteAccountModel.fromJson(Map json) {
    if (!json.containsKey("accessToken")) {
      throw HttpError.invalidData;
    }
    return RemoteAccountModel(json["accessToken"]);
  }

  AccountEntity toEntity() => AccountEntity(accessToken);
}
