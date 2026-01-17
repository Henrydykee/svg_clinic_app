import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:savouge/features/onboarding/presentation/pages/splash_screen.dart';

import 'core/di/di_config.dart';
import 'core/presentation/state/provider_initializer.dart';
import 'core/presentation/widgets/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initInjectors();
  runApp(savogue());
}

class savogue extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MultiProvider(
        providers: ProviderInitializer.providers,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey:  router.navigatorKey,
            theme: ThemeData(
              fontFamily: 'avenir',
              useMaterial3: false,
              appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
            ),
            home: SplashScreen(),
          ),
        ),
      ),
    );
  }
}
