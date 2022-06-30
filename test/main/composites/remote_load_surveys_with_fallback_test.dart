import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/data/usecases/load_surveys/remote_load_surveys.dart';

class RemoteLoadSurveysWithLocalFallBack {
  final RemoteLoadSurveys remote;
  RemoteLoadSurveysWithLocalFallBack({required this.remote});
  Future<void> load() async {
   await remote.load();
  }
}

class RemoteLoadSurveysSpy extends Mock implements RemoteLoadSurveys {}

void main() {
  setUp(() {});

  test("should call remote load", () async {
    final remote = RemoteLoadSurveysSpy();
    final sut = RemoteLoadSurveysWithLocalFallBack(remote: remote);
    await sut.load();

    verify(() => remote.load()).called(1);
  });
}
