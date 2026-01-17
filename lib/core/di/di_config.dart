import 'package:get_it/get_it.dart';

import '../../features/auth/domain/di/auth_injector.dart';
import 'core_di.dart';

GetIt inject = GetIt.instance;
/// Registration of service dependencies with  service locator GetIt
///
/// Add any such dependency here
Future<void> initInjectors()  async {
  await coreInjector();
  await authInjector();
}
