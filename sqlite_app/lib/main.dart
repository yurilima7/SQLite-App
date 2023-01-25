import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_app/screens/add_usuario.dart';
import 'package:sqlite_app/screens/update_usuarios.dart';
import 'package:sqlite_app/provider/user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AddUsuario(),

        routes: {
          '/update':(context) => const UpdateUsuarios()
        },
      ),
    );
  }
}
