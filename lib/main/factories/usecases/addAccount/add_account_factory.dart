import 'package:tdd_clean_patterns_solid/data/usecases/add_account/remote_add_account.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/add_account/add_account.dart';
import '../../http/api_url_factory.dart';
import '../../http/http_client_factory.dart';

AddAccount makeRemoteAddAcccount() {
  return RemoteAddAccount(
    httpClient: makeHttpAdapter(),
    url: makeApiUrl('signup'),
  );
}
