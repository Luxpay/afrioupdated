import 'package:get_it/get_it.dart';

import 'authService.dart';
// import 'push_notification_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => LocalAuthenticationService());
  // locator.registerLazySingleton(() => PushNotificationService());
}