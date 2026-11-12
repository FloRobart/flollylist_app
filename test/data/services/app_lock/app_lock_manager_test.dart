import 'package:hollylist_app/config/shared_preferences_keys.dart';
import 'package:hollylist_app/data/services/app_lock/app_lock_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Creates a container, then waits for the lock to be read from the storage.
Future<ProviderContainer> createSettledContainer() async {
  final container = ProviderContainer();
  addTearDown(container.dispose);

  container.read(appLockManagerProvider);
  for (var attempt = 0; attempt < 50; attempt++) {
    if (container.read(appLockManagerProvider) != AppLockStatus.unknown) break;
    await Future<void>.delayed(Duration.zero);
  }

  return container;
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  group('AppLockManager', () {
    test('Asks for a new code when none is stored', () async {
      final container = await createSettledContainer();

      expect(container.read(appLockManagerProvider), AppLockStatus.needsSetup);
    });

    test(
      'Stores only the hash of the code, then opens the application',
      () async {
        final container = await createSettledContainer();

        await container.read(appLockManagerProvider.notifier).setCode('1234');

        final preferences = await SharedPreferences.getInstance();
        expect(
          preferences.getString(SharedPreferencesKeys.appLockCodeHash),
          isNot(contains('1234')),
        );
        expect(container.read(appLockManagerProvider), AppLockStatus.unlocked);
      },
    );

    test(
      'Starts locked when a code exists, and only opens with this code',
      () async {
        final firstContainer = await createSettledContainer();
        await firstContainer
            .read(appLockManagerProvider.notifier)
            .setCode('1234');

        final container = await createSettledContainer();
        final appLockManager = container.read(appLockManagerProvider.notifier);
        expect(container.read(appLockManagerProvider), AppLockStatus.locked);

        expect(await appLockManager.unlock('0000'), isFalse);
        expect(container.read(appLockManagerProvider), AppLockStatus.locked);

        expect(await appLockManager.unlock('1234'), isTrue);
        expect(container.read(appLockManagerProvider), AppLockStatus.unlocked);
      },
    );

    test('Locks again on demand', () async {
      final container = await createSettledContainer();
      final appLockManager = container.read(appLockManagerProvider.notifier);
      await appLockManager.setCode('1234');

      appLockManager.lock();

      expect(container.read(appLockManagerProvider), AppLockStatus.locked);
    });

    test('Is opened by a login only if a code exists', () async {
      final container = await createSettledContainer();
      final appLockManager = container.read(appLockManagerProvider.notifier);

      appLockManager.unlockAfterLogin();
      expect(container.read(appLockManagerProvider), AppLockStatus.needsSetup);

      await appLockManager.setCode('1234');
      appLockManager.lock();
      appLockManager.unlockAfterLogin();
      expect(container.read(appLockManagerProvider), AppLockStatus.unlocked);
    });

    test('Forgets the code on reset', () async {
      final container = await createSettledContainer();
      final appLockManager = container.read(appLockManagerProvider.notifier);
      await appLockManager.setCode('1234');

      await appLockManager.reset();

      expect(container.read(appLockManagerProvider), AppLockStatus.needsSetup);
      expect(await appLockManager.unlock('1234'), isFalse);
    });
  });
}
