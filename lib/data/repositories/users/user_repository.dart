import 'package:flollylist_app/data/repositories/users/user_repository_impl.dart';
import 'package:flollylist_app/data/repositories/users/user_repository_remote.dart';
import 'package:flollylist_app/data/services/api/users/user_api_client.dart';
import 'package:flollylist_app/data/services/auth/auth_manager.dart';
import 'package:flollylist_app/domain/models/users/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fournit une instance d'[UserRepository].
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final remote = UserRepositoryRemote(
    userApiClient: ref.read(userApiClientProvider),
    authManager: ref.read(authNotifierProvider.notifier),
  );

  return UserRepositoryImpl(
    remote: remote,
    authNotifier: ref.read(authNotifierProvider.notifier),
  );
});

/// Repository interface for users data.
abstract class UserRepository {
  Future<User> getCurrentUser();
  Future<void> updatePseudo(String newPseudo);
  Future<void> logoutAll();
  Future<void> logout();
}
