

import 'package:tdd_clean_patterns_solid/data/usecases/load_surveys/remote_load_surveys.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/load_surveys/load_surverys.dart';
import 'package:tdd_clean_patterns_solid/main/factories/http/api_url_factory.dart';
import 'package:tdd_clean_patterns_solid/main/factories/http/http_client_factory.dart';

LoadSurveys makeRemoteLoadSurveys(){
  return RemoteLoadSurveys(httpClient: makeHttpAdapter(), url: makeApiUrl("surveys"));
}