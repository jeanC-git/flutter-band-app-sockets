import 'package:flutter/material.dart';

import 'package:band_app/pages/HomePage.dart';
import 'package:band_app/pages/StatusPage.dart';
import 'package:provider/provider.dart';
import 'package:band_app/services/SocketService.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SocketService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'home': (context) => HomePage(),
          'status': (context) => StatusPage()
        },
      ),
    );
  }
}
