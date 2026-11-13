import 'package:hollylist_app/data/repositories/auth/auth_repository_impl.dart';
import 'package:hollylist_app/data/repositories/auth/auth_repository_local.dart';
import 'package:hollylist_app/data/repositories/auth/auth_repository_remote.dart';
import 'package:hollylist_app/data/services/api/auth/auth_api_client.dart';
import 'package:hollylist_app/data/services/auth/auth_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fournit une instance d'[AuthRepository].
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remote = AuthRepositoryRemote(
    authApiClient: ref.read(authApiClientProvider),
  );
  final local = AuthRepositoryLocal();
  final globalAuthNotifier = ref.read(authNotifierProvider.notifier);

  return AuthRepositoryImpl(
    remote: remote,
    local: local,
    globalAuthNotifier: globalAuthNotifier,
  );
});

/// Repository interface for authentication operations.
abstract class AuthRepository {
  Future<void> requestLoginCode(String email);
  Future<void> confirmLoginCode(String secret);
  Future<String?> getEmail();
}
