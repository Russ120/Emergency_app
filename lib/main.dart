// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, use_super_parameters

import 'package:flutter/material.dart';

import 'pages/RegistrarEventos.dart';
import 'pages/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key})
      : super(key: key); // Corrección en la definición del constructor
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home:
          MenuPages(), // Cambié WelcomePage() por TabMenuPage() para tener el menú en la página de inicio
      routes: {
        '/nuevo_evento': (context) => NuevoEventoForm(),
      },
      debugShowCheckedModeBanner: false, // Elimina la cinta de depuración
    );
  }
}
