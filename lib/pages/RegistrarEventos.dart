// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

import '../database/db.dart';
import '../database/evento.dart';

class NuevoEventoForm extends StatefulWidget {
  @override
  _NuevoEventoFormState createState() => _NuevoEventoFormState();
}

class _NuevoEventoFormState extends State<NuevoEventoForm> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos de texto
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Fecha'),
              ),
              TextFormField(
                controller: _photoController,
                decoration: const InputDecoration(labelText: 'Foto'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Convertir la fecha del controlador a DateTime
                    DateTime? fecha;
                    if (_dateController.text.isNotEmpty) {
                      fecha = DateTime.parse(_dateController.text);
                    }

                    // Crear un nuevo evento con los datos ingresados
                    Evento nuevoEvento = Evento(
                      // id: null, // Puedes proporcionar un valor predeterminado o permitir que se genere automáticamente en la base de datos
                      title: _titleController.text,
                      description: _descriptionController.text,
                      date:
                          fecha, // Asignar el valor de fecha convertido a DateTime
                      photo: _photoController.text,
                    );

                    // Guardar el nuevo evento en la base de datos
                    DB.insert(nuevoEvento);

                    // Mostrar un mensaje de éxito
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Evento registrado exitosamente'),
                      ),
                    );

                    // Limpiar los campos del formulario después de guardar el evento
                    _titleController.clear();
                    _descriptionController.clear();
                    _dateController.clear();
                    _photoController.clear();
                  }
                },
                child: Text('Guardar Evento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
