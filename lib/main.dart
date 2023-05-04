import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pitagoras_app/users/authentication/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //Permite que la informacion cargue de forma segura (importante usar)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pitagoras',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        builder: (context, dataSnapShot)
        {
        return LoginScreen();
        },
      )
    );
  }
}

