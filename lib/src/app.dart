import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './config/routes.dart';

class App extends StatelessWidget {
  const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: buildRoutes(),
      home: const HomeScreen(),
    );
  }
}
