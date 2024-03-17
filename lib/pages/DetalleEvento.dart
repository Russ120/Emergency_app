// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'dart:io';

import 'package:examen_2_emergency_app/database/evento.dart';
import 'package:flutter/material.dart';

class DetalleEvento extends StatelessWidget {
  final Evento evento;

  const DetalleEvento({Key? key, required this.evento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalles del evento')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Mostrar la imagen del evento
            Image.file(File(evento.photo?.toString() ?? '')),
            // Mostrar el título del evento
            Text(evento.title),
            // Mostrar la descripción del evento
            Text(evento.description),
            // Mostrar la fecha del evento
            Text(evento.date?.toString() ?? ''),
          ],
        ),
      ),
    );
  }
}
