import 'package:acenet_project/views/form_spk_page.dart';
import 'package:acenet_project/views/history_page.dart';
import 'package:acenet_project/views/home_page.dart';
import 'package:acenet_project/views/login_screen.dart';
import 'package:acenet_project/views/splashscreen.dart';
import 'package:acenet_project/views/today_task_page.dart';
import 'package:acenet_project/views/upcoming_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => HomePage());

      case '/today':
        return MaterialPageRoute(builder: (_) => TodayTaskPage());

      case '/history':
        return MaterialPageRoute(builder: (_) => HistoryPage());


      case '/splashscreen':
        return MaterialPageRoute(builder: (_) => SplashScreenPage());

      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case '/upcoming':
        // if (args is String) {
        return MaterialPageRoute(builder: (_) => UpcomingTaskPage());
      // }
      // return _errorRoute();

      case '/detailPekerjaan':
        if (args is int) {
          return MaterialPageRoute(builder: (_) => FormSPK(idPekerjaan: args));
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("ERROR"),
        ),
        body: Center(child: Text("ERROR")),
      );
    });
  }
}
