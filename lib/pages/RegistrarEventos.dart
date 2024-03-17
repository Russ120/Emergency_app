// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unnecessary_null_comparison, no_leading_underscores_for_local_identifiers, await_only_futures, unused_local_variable, avoid_unnecessary_containers, unused_element

import 'package:flutter/material.dart';

// import 'package:image_picker/image_picker.dart';

import '../database/db.dart';
import '../database/evento.dart';

class NuevoEventoForm extends StatefulWidget {
  @override
  _NuevoEventoFormState createState() => _NuevoEventoFormState();
}

class _NuevoEventoFormState extends State<NuevoEventoForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _fecha;

  // Controladores para los campos de texto
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  // final TextEditingController _photoController = TextEditingController();

  // Variables para manejar la foto
  // XFile? _image;

  // String? imagePath;
  void _limpiar() {
    _titleController.clear();
    _descriptionController.clear();
    _dateController.clear();
    // _photoController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text('Registrar un nuevo evento'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                "Registrar un nuevo evento",
                style: TextStyle(
                  fontSize: 24,
                  color: const Color.fromARGB(255, 32, 32, 32),
                ),
              ),
              // TITULO
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
              // DESCRIPCION
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
              // FECHA
              // TextFormField(
              //     controller: _dateController,
              //     decoration: const InputDecoration(labelText: 'Fecha'),
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Por favor ingrese una fecha';
              //       }
              //       return null;
              //     }),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  DateTime? fecha = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
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

              //------------------------------------------
              // segunda opcion
              // (imagePath == null || imagePath.isEmpty)
              //     ? Container()
              //     : Image.file(File(imagePath)),

              // ElevatedButton(
              //     child: Text("Insertar imagen"),
              //     onPressed: () async {
              //       final ImagePicker _picker = ImagePicker();
              //       XFile? _pickeFile =
              //           await _picker.pickImage(source: ImageSource.gallery);
              //       imagePath = (_pickeFile?.path)!;
              //       setState(() {});
              //     }),

              //----------------------------------------
              // tercera opcion
              // ElevatedButton(
              //   child: Text("Seleccionar una imagen"),
              //   onPressed: () async {
              //     final ImagePicker _picker = ImagePicker();
              //     final XFile? pickedFile =
              //         await _picker.pickImage(source: ImageSource.gallery);
              //     imagePath = pickedFile?.path;
              //     setState(() {});
              //   },
              // ),

              // (imagePath == null)
              //     ? Container(
              //         child: Text("hola"),
              //       )
              //     : Image.file(File(imagePath!)),

              //------------------------------------------
              // original
              // PHOTO
              // TextFormField(
              //     controller: _photoController,
              //     decoration: const InputDecoration(labelText: 'Foto'),
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Por favor ingrese una foto';
              //       }
              //       return null;
              //     }),

              //-------------------------------
              // intentando
              // SizedBox(height: 40),
              // Text("Imagen", style: TextStyle(fontSize: 16)),
              // SizedBox(height: 10),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              //   onPressed: () async {
              //     final image = await ImagePicker()
              //         .pickImage(source: ImageSource.gallery);
              //     if (image != null) {
              //       setState(() {
              //         _image = image;
              //       });
              //     }
              //   },
              //   child: const Text(
              //     'Seleccionar foto',
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),

              // // Mostrar la imagen seleccionada si existe
              // if (_image != null) Image.file(_image! as File),

              const SizedBox(height: 20),
              // BOTON
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Color de fondo azul
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Crear un nuevo evento con los datos ingresados
                        Evento nuevoEvento = Evento(
                          // id: null, // Puedes proporcionar un valor predeterminado o permitir que se genere automáticamente en la base de datos
                          title: _titleController.text,
                          description: _descriptionController.text,
                          date:
                              _fecha, // Asignar el valor de fecha convertido a DateTime
                          // photo: _photoController.text,
                          photo: _titleController.text,
                        );

                        // Guardar el nuevo evento en la base de datos
                        DB.insert(nuevoEvento);

                        // Mostrar un mensaje de éxito
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Evento registrado exitosamente'),
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
                      backgroundColor: Colors.red, // Color de fondo azul
                    ),
                    onPressed: () {
                      _limpiar();
                    },
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
