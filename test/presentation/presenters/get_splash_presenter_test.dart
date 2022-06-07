import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_patterns_solid/domain/entities/account_entity.dart';
import 'package:tdd_clean_patterns_solid/domain/usecases/load_curret_account.dart';
import 'package:tdd_clean_patterns_solid/presentation/presenters/get_splash_presenter.dart';

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

void main() {
  late LoadCurrentAccountSpy loadCurrentAccount;
  late GetXSplashPresenter sut;
  void mockLoadCurrentAccount({required AccountEntity? account}) {
    when(() => loadCurrentAccount.load()).thenAnswer((_) async => account);
  }

  void mockLoadCurrentAccountError() {
    when(() => loadCurrentAccount.load()).thenThrow((Exception()));
  }

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetXSplashPresenter(loadCurrentAccount: loadCurrentAccount);
    mockLoadCurrentAccount(account: AccountEntity(faker.guid.guid()));
  });

  test("should call LoadCurrentAccount", () async {
    await sut.checkAccount();
    verify(() => loadCurrentAccount).called(1);
  });

  test("should  go to surveys page on success", () async {
    sut.navigateToStream.listen(
      expectAsync1(
        (page) => expect(page, "/surveys"),
      ),
    );
    await sut.checkAccount();
  });

  test("should  go to login page on null result", () async {
    mockLoadCurrentAccount(account: null);
    sut.navigateToStream.listen(
      expectAsync1(
        (page) => expect(page, "/login"),
      ),
    );
    await sut.checkAccount();
  });

  test("should  go to login page on error", () async {
    mockLoadCurrentAccountError();
    sut.navigateToStream.listen(
      expectAsync1(
        (page) => expect(page, "/login"),
      ),
    );
    await sut.checkAccount();
  });
}
