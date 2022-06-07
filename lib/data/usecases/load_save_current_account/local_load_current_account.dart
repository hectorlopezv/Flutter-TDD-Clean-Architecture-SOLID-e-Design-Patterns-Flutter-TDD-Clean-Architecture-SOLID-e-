import '../../../domain/entities/account_entity.dart';
import '../../../domain/helpers/domain_error.dart';
import '../../../domain/usecases/load_curret_account.dart';
import '../../cache/fetch_secure_cache_storage.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  LocalLoadCurrentAccount({required this.fetchSecureCacheStorage});

  @override
  Future<AccountEntity> load() async {
    try {
      final token = await fetchSecureCacheStorage.fetchSecure("token");
      return AccountEntity(token ?? "");
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
