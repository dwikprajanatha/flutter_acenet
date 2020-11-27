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
      title: "Test Program",
      theme: ThemeData(
        primaryColor: Colors.red[900],
      ),
      initialRoute: '/dashboard',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
