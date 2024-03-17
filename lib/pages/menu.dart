// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'Portada.dart';
import 'RegistrarEventos.dart';

class TabMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Número de pestañas
      child: Scaffold(
        appBar: AppBar(
          title: Text('Emergency app'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Inicio'),
              Tab(text: 'Nuevo Evento'),
              Tab(text: 'Eventos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [WelcomePage(), NuevoEventoForm(), NuevoEventoForm()],
        ),
      ),
    );
  }
}
