import 'package:flutter/material.dart'; // primero clases de flutter
import 'package:provider/provider.dart';

import 'package:sockets/pages/home.dart';
import 'package:sockets/pages/status.dart';
import 'package:sockets/services/socket_service.dart'; // tercero las clases propias
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => SocketService())  
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'home': (_) => HomePage(),
          'status': (_) => StatusPage()
        },
      ),
    );
  }
}