import 'package:flutter/material.dart';
import 'login/login_screen.dart';

import 'package:provider/provider.dart';
import 'pages/widgets/notification_provider.dart'; 

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Encode',
      ),
      home: LoginScreen(),
    );
  }
}
