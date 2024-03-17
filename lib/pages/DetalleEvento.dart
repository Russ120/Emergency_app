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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Mostrar la imagen del evento con un tamaño máximo predefinido
            SizedBox(
              height: 400, // Altura máxima para la imagen
              child: Image.file(
                File(evento.photo?.toString() ?? ''),
                fit: BoxFit.cover, // Ajustar la imagen para cubrir el espacio
              ),
            ),
            const SizedBox(
                height: 20), // Espaciado entre la imagen y el contenido
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Mostrar el título del evento con un estilo de texto grande y en negrita
                  Text(
                    evento.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                      height: 10), // Espaciado entre el título y la descripción
                  // Mostrar la descripción del evento con un estilo de texto normal
                  Text(
                    evento.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                      height: 10), // Espaciado entre la descripción y la fecha
                  // Mostrar la fecha del evento con un estilo de texto pequeño y en gris
                  Text(
                    'Fecha: ${evento.date?.toString() ?? ''}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
