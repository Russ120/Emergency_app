// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '¡Bienvenido a mi app!',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
