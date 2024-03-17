// ignore_for_file: library_private_types_in_public_api, use_super_parameters, prefer_const_constructors

// import 'package:flutter/material.dart';

// // import 'package:image_picker/image_picker.dart';

// import '../database/db.dart';
// import '../database/evento.dart';

// class EditarEvento extends StatefulWidget {
//   final Evento eventoParaEditar;

//   const EditarEvento({Key? key, required this.eventoParaEditar})
//       : super(key: key);

//   @override
//   _EditarEventoState createState() => _EditarEventoState();
// }

// class _EditarEventoState extends State<EditarEvento> {
//   final _formKey = GlobalKey<FormState>();
//   DateTime? _fecha;

//   // Controladores para los campos de texto
//   late TextEditingController _titleController;
//   late TextEditingController _descriptionController;
//   late TextEditingController _dateController;
//   // late TextEditingController _photoController;

//   @override
//   void initState() {
//     super.initState();

//     // Inicializar los controladores con los valores del evento a editar
//     _titleController =
//         TextEditingController(text: widget.eventoParaEditar.title);
//     _descriptionController =
//         TextEditingController(text: widget.eventoParaEditar.description);
//     _dateController = TextEditingController(
//         text: widget.eventoParaEditar.date?.toString() ?? '');
//     _fecha = widget.eventoParaEditar.date;
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descriptionController.dispose();
//     _dateController.dispose();
//     // _photoController.dispose();
//     super.dispose();
//   }

//   void _limpiar() {
//     _formKey.currentState!.reset();
//     _fecha = null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Editar evento')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: <Widget>[
//               SizedBox(height: 20),
//               Text(
//                 "Editar evento",
//                 style: TextStyle(
//                   fontSize: 24,
//                   color: const Color.fromARGB(255, 32, 32, 32),
//                 ),
//               ),
//               // TITULO
//               TextFormField(
//                 controller: _titleController,
//                 decoration: const InputDecoration(labelText: 'Título'),
//                 maxLines: 2,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Por favor ingrese un título';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 15),
//               TextFormField(
//                 controller: _descriptionController,
//                 decoration: const InputDecoration(labelText: 'Descripción'),
//                 maxLines: 3,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Por favor ingrese una descripción';
//                   }
//                   return null;
//                 },
//               ),
//               // FECHA
//               SizedBox(height: 15),
//               GestureDetector(
//                 onTap: () async {
//                   DateTime? fecha = await showDatePicker(
//                     context: context,
//                     initialDate: _fecha ?? DateTime.now(),
//                     firstDate: DateTime(2000),
//                     lastDate: DateTime(2030),
//                   );
//                   if (fecha != null) {
//                     _dateController.text = fecha.toString();
//                     _fecha = fecha;
//                   }
//                 },
//                 child: AbsorbPointer(
//                   child: TextFormField(
//                     controller: _dateController,
//                     decoration: const InputDecoration(labelText: 'Fecha'),
//                     maxLines: 2,
//                     enabled: true,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               // BOTON
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue, // Color de fondo azul
//                     ),
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         // Modificar el evento en la base de datos
//                         DB.update(
//                           Evento(
//                             id: widget.eventoParaEditar.id, // Preservar el ID
//                             title: _titleController.text,
//                             description: _descriptionController.text,
//                             date: _fecha,
//                             // photo: _photoController.text,
//                             photo: _titleController.text,
//                           ),
//                         );
//                         // Mostrar un mensaje de éxito
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('Evento registrado exitosamente'),
//                           ),
//                         );
//                         _limpiar();
//                       }
//                     },
//                     child:
//                         Text('Guardar', style: TextStyle(color: Colors.white)),
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red, // Color de fondo azul
//                     ),
//                     onPressed: () {
//                       _limpiar();
//                     },
//                     child:
//                         Text("Cancelar", style: TextStyle(color: Colors.white)),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../database/db.dart';
import '../database/evento.dart';

class EditarEvento extends StatefulWidget {
  final Evento eventoParaEditar;

  const EditarEvento({Key? key, required this.eventoParaEditar})
      : super(key: key);

  @override
  _EditarEventoState createState() => _EditarEventoState();
}

class _EditarEventoState extends State<EditarEvento> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _fecha;
  File? _imageFile; // Almacenar la imagen seleccionada

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.eventoParaEditar.title);
    _descriptionController =
        TextEditingController(text: widget.eventoParaEditar.description);
    _dateController = TextEditingController(
        text: widget.eventoParaEditar.date?.toString() ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _limpiar() {
    _formKey.currentState!.reset();
    _fecha = null;
    setState(() {
      _imageFile = null; // Limpiar la imagen seleccionada
    });
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path); // Almacenar la imagen seleccionada
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar evento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                "Editar evento",
                style: TextStyle(
                  fontSize: 24,
                  color: const Color.fromARGB(255, 32, 32, 32),
                ),
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un título';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  DateTime? fecha = await showDatePicker(
                    context: context,
                    initialDate: _fecha ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2030),
                  );
                  if (fecha != null) {
                    _dateController.text = fecha.toString();
                    _fecha = fecha;
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dateController,
                    decoration: const InputDecoration(labelText: 'Fecha'),
                    maxLines: 2,
                    enabled: true,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Mostrar la imagen seleccionada o el botón para seleccionar una nueva
              _imageFile != null
                  ? Image.file(_imageFile!)
                  : ElevatedButton(
                      onPressed: _selectImage,
                      child: Text('Seleccionar Nueva Imagen'),
                    ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        DB.update(
                          Evento(
                            id: widget.eventoParaEditar.id,
                            title: _titleController.text,
                            description: _descriptionController.text,
                            date: _fecha,
                            photo: _imageFile
                                ?.path, // Convertir el File en una cadena de ruta
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Evento actualizado exitosamente'),
                          ),
                        );
                        _limpiar();
                      }
                    },
                    child:
                        Text('Guardar', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: _limpiar,
                    child:
                        Text("Cancelar", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
