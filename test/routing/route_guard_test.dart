import 'package:hollylist_app/data/services/app_lock/app_lock_manager.dart';
import 'package:hollylist_app/data/services/auth/auth_manager.dart';
import 'package:hollylist_app/routing/route_guard.dart';
import 'package:hollylist_app/routing/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('resolveRedirect', () {
    test('Waits on the loading screen while the session is unknown', () {
      expect(
        resolveRedirect(
          authStatus: AuthStatus.unknown,
          appLockStatus: AppLockStatus.unknown,
          location: AppRoutes.home,
        ),
        AppRoutes.loading,
      );
    });

    test('Sends a logged out user to the login screen, whatever the page', () {
      for (final location in [
        AppRoutes.home,
        AppRoutes.profile,
        AppRoutes.appLock,
        '/peoples/3',
      ]) {
        expect(
          resolveRedirect(
            authStatus: AuthStatus.unauthenticated,
            appLockStatus: AppLockStatus.locked,
            location: location,
          ),
          AppRoutes.login,
        );
      }
    });

    test('Lets a logged out user on the login and code screens', () {
      for (final location in [AppRoutes.login, AppRoutes.codeEntry]) {
        expect(
          resolveRedirect(
            authStatus: AuthStatus.unauthenticated,
            appLockStatus: AppLockStatus.needsSetup,
            location: location,
          ),
          isNull,
        );
      }
    });

    test(
      'Hides the data of a logged in user until the code is set or typed',
      () {
        for (final appLockStatus in [
          AppLockStatus.needsSetup,
          AppLockStatus.locked,
        ]) {
          expect(
            resolveRedirect(
              authStatus: AuthStatus.authenticated,
              appLockStatus: appLockStatus,
              location: '/peoples/3',
            ),
            AppRoutes.appLock,
          );
        }
      },
    );

    test('Leaves the lock screen alone while it is needed', () {
      expect(
        resolveRedirect(
          authStatus: AuthStatus.authenticated,
          appLockStatus: AppLockStatus.locked,
          location: AppRoutes.appLock,
        ),
        isNull,
      );
    });

    test('Opens the application once unlocked', () {
      for (final location in [
        AppRoutes.loading,
        AppRoutes.login,
        AppRoutes.codeEntry,
        AppRoutes.appLock,
      ]) {
        expect(
          resolveRedirect(
            authStatus: AuthStatus.authenticated,
            appLockStatus: AppLockStatus.unlocked,
            location: location,
          ),
          AppRoutes.home,
        );
      }
    });

    test('Lets an unlocked user go to any page of the application', () {
      for (final location in [
        AppRoutes.home,
        AppRoutes.profile,
        '/peoples/3',
      ]) {
        expect(
          resolveRedirect(
            authStatus: AuthStatus.authenticated,
            appLockStatus: AppLockStatus.unlocked,
            location: location,
          ),
          isNull,
        );
      }
    });
  });
}
