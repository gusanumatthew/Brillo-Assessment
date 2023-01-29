import 'package:brilloconnetz_test/src/features/Dashboard/dashboard_view.dart';
import 'package:brilloconnetz_test/src/features/authentication/view/login_view.dart';
import 'package:brilloconnetz_test/src/features/authentication/view/register_view.dart';
import 'package:brilloconnetz_test/src/features/profile/model/app_user.dart';
import 'package:flutter/material.dart';

class Routes {
  static const login = '/loginView';
  static const register = '/registerView';
  static const dashboard = '/brillo';
  static const welcome = '/welcomeView';
  static const verifyEmail = '/verifyEmail';
  static const home = '/homeView';
  static const chat = '/chatView';
  static const profile = '/profileView';
  static const add = '/addForum';
  static const fView = '/forumView';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case onboard:
      //   return MaterialPageRoute(builder: (_) => const OnboardingView());
      // case welcome:
      //   return MaterialPageRoute(builder: (_) => const WelcomeView());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case dashboard:
        // final appUser = settings.arguments as AppUser;
        return MaterialPageRoute(builder: (_) => DashboardView());
      // case verifyEmail:
      //   return MaterialPageRoute(builder: (_) => const VerifyEmailView());
      // case add:
      //   return MaterialPageRoute(builder: (_) => const AddForumView());
      // case fView:
      //   final forum = settings.arguments as Forum;
      //   return MaterialPageRoute(builder: (_) => ForumView(forum: forum));

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
