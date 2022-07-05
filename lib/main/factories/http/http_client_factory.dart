import 'package:http/http.dart';
import 'package:tdd_clean_patterns_solid/data/http/http_client.dart';
import '../../../infra/http/http_adapter.dart';

HttpClientDemo makeHttpAdapter() {
  final client = Client();
  return HttpAdapter(client);
}
