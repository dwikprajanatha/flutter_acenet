import 'package:acenet_project/routes/route_generator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Acenet",
      theme: ThemeData(
        primaryColor: Colors.red[900],
      ),
      initialRoute: '/splashscreen',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
