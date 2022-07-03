import 'package:http/http.dart';
import 'package:tdd_clean_patterns_solid/data/cache/fetch_secure_cache_storage.dart';
import 'package:tdd_clean_patterns_solid/data/http/http_client.dart';
import 'package:tdd_clean_patterns_solid/infra/http/http_adapter.dart';
import 'package:tdd_clean_patterns_solid/main/decorators/authorize_http_client_decorator.dart';
import 'package:tdd_clean_patterns_solid/main/factories/cache/secure_storage_adapter_factory.dart';
import 'package:tdd_clean_patterns_solid/main/factories/http/http_client_factory.dart';

HttpClientDemo makeAuthorizeHttpClientDecorator() =>
    AuthorizeHttpClientDecorator(
      decoratee: makeHttpAdapter(),
      fetchSecureCacheStorage: makeSecureStorageAdapter(),
    );
