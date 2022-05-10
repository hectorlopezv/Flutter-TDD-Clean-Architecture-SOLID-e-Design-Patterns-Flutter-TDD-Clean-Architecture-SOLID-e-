import '../../../../data/usecases/remote_authentication.dart';
import '../../../../domain/usecases/authentication.dart';
import '../../http/api_url_factory.dart';
import '../../http/http_client_factory.dart';

Authentication makeRemoteAuthentication() {
  return RemoteAuthentication(
      httpClient: makeHttpAdapter(), url: makeApiUrl('login'));
}
