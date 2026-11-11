import 'package:flollylist_app/data/models/users/user_dto.dart';
import 'package:flollylist_app/data/models/users/user_dto_mapper.dart';
import 'package:flollylist_app/data/repositories/users/user_repository.dart';
import 'package:flollylist_app/data/repositories/users/user_repository_remote.dart';
import 'package:flollylist_app/data/services/auth/auth_manager.dart';
import 'package:flollylist_app/domain/models/users/user.dart';

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl({required this.remote, required this.authNotifier});

  final UserRepositoryRemote remote;
  final AuthManager authNotifier;

  /// Fails when the server does not answer: the profile screen then shows an error
  /// instead of a made-up user.
  @override
  Future<User> getCurrentUser() async {
    final UserDto userDto = await remote.getCurrentUser();
    return userDto.toDomain();
  }

  @override
  Future<void> updatePseudo(String newPseudo) {
    return remote.updatePseudo(newPseudo);
  }

  /// Déconnecte l'utilisateur de tous les appareils, puis de celui-ci.
  @override
  Future<void> logoutAll() async {
    await remote.logoutAll();
    await authNotifier.logout();
  }

  @override
  Future<void> logout() {
    return authNotifier.logout();
  }
}
