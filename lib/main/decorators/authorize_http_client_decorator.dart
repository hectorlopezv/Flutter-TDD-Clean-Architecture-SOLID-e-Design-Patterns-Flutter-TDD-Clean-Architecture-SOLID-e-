import 'package:tdd_clean_patterns_solid/data/cache/delete_secure_cache_storage.dart';
import 'package:tdd_clean_patterns_solid/data/http/http_error.dart';
import '../../data/cache/fetch_secure_cache_storage.dart';
import '../../data/http/http_client.dart';

class AuthorizeHttpClientDecorator implements HttpClientDemo {
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  final DeleteSecureCacheStorage deleteSecureCacheStorage;
  final HttpClientDemo decoratee;

  AuthorizeHttpClientDecorator(
      {required this.fetchSecureCacheStorage,
      required this.decoratee,
      required this.deleteSecureCacheStorage});
  Future<dynamic> request(
      {required String url,
      required String method,
      Map? body,
      Map? headers}) async {
    try {
      //Base Case
      final token = await fetchSecureCacheStorage.fetch("token");

      final authorizeHeaders = headers ?? {}
        ..addAll({"x-access-token": token});
      return await decoratee.request(
          url: url, method: method, body: body, headers: authorizeHeaders);
    } catch (error) {
      if (error is HttpError && error != HttpError.forbidden) {
        rethrow;
      } else {
        await deleteSecureCacheStorage.delete(key: "token");
        throw HttpError.forbidden;
      }
    }
  }
}
