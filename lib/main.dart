import 'package:brilloconnetz_test/firebase_options.dart';
import 'package:brilloconnetz_test/src/core/constants/strings.dart';
import 'package:brilloconnetz_test/src/core/routes.dart';
import 'package:brilloconnetz_test/src/core/themes.dart';
import 'package:brilloconnetz_test/src/features/start_up/splash_view.dart';
import 'package:brilloconnetz_test/src/services/local_database.dart/database_services.dart';
import 'package:brilloconnetz_test/src/services/navigation_service.dart';
import 'package:brilloconnetz_test/src/services/snackbar_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/features/authentication/model/interest_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(InterestAdapter());
  await HiveStorage.openBox();
  await Hive.openBox<Interest>('interestBox');
  runApp(const ProviderScope(child: BrillTest()));
}

class BrillTest extends ConsumerWidget {
  const BrillTest({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      home: const SplashView(),
      onGenerateRoute: Routes.generateRoute,
      navigatorKey: ref.read(navigationService).navigatorKey,
      scaffoldMessengerKey: ref.read(snackbarService).scaffoldMessengerKey,
    );
  }
}
