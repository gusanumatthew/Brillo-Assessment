import 'package:brilloconnetz_test/src/features/Dashboard/dashboard_view.dart';
import 'package:brilloconnetz_test/src/features/authentication/view/forgot_password_view.dart';
import 'package:brilloconnetz_test/src/features/authentication/view/login_view.dart';
import 'package:brilloconnetz_test/src/features/authentication/view/register_view.dart';
import 'package:brilloconnetz_test/src/features/authentication/view/verify_email.dart';
import 'package:brilloconnetz_test/src/features/profile/model/app_user.dart';
import 'package:flutter/material.dart';

class Routes {
  static const login = '/loginView';
  static const register = '/registerView';
  static const dashboard = '/brillo';

  static const verifyEmail = '/verifyEmail';

  static const profile = '/profileView';
  static const forgot = '/forgot';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case dashboard:
        final appUser = settings.arguments as AppUser;
        return MaterialPageRoute(
            builder: (_) => DashboardView(
                  user: appUser,
                ));
      case verifyEmail:
        return MaterialPageRoute(builder: (_) => const VerifyEmailView());
      case forgot:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
