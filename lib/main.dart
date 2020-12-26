import 'package:flutter/material.dart'; // primero clases de flutter

import 'package:sockets/pages/home.dart'; // tercero las clases propias
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomePage()
      },
    );
  }
}