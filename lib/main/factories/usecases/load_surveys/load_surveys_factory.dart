

import 'package:tdd_clean_patterns_solid/data/usecases/load_surveys/local_load_surveys.dart';
import 'package:tdd_clean_patterns_solid/data/usecases/load_surveys/remote_load_surveys.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/load_surveys/load_surverys.dart';
import 'package:tdd_clean_patterns_solid/main/composites/remote_load_surveys_with_fallback.dart';
import 'package:tdd_clean_patterns_solid/main/factories/cache/local_storage_adapter_factory.dart';
import 'package:tdd_clean_patterns_solid/main/factories/http/api_url_factory.dart';
import 'package:tdd_clean_patterns_solid/main/factories/http/authorize_client_decorator_factory.dart';
import 'package:tdd_clean_patterns_solid/main/factories/http/http_client_factory.dart';

RemoteLoadSurveys makeRemoteLoadSurveys(){
  return RemoteLoadSurveys(httpClient: makeAuthorizeHttpClientDecorator(), url: makeApiUrl("surveys"));
}


LocalLoadSurveys makeLocalLoadSurveys(){
  return LocalLoadSurveys(cacheStorage: makeLocalStorageAdapter());
}


LoadSurveys makeRemoteLoadSurveysWithLocalFallBack(){
  return RemoteLoadSurveysWithLocalFallBack( local: makeLocalLoadSurveys(), remote: makeRemoteLoadSurveys());
}