// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, avoid_print

// import 'dart:io';

// import 'package:examen_2_emergency_app/database/evento.dart';
// import 'package:examen_2_emergency_app/pages/DetalleEvento.dart';
// import 'package:flutter/material.dart';

// import '../database/db.dart';

// class EventosPage extends StatefulWidget {
//   @override
//   _EventosPageState createState() => _EventosPageState();
// }

// class _EventosPageState extends State<EventosPage> {
//   Future<List<Evento>>? eventos;

//   @override
//   void initState() {
//     super.initState();
//     eventos = DB.getAllEvents();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Eventos')),
//       body: FutureBuilder(
//         future: eventos,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final eventos = snapshot.data as List<Evento>;
//             return ListView.builder(
//               itemCount: eventos.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     // Navegar a la vista de detalles del evento
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             DetalleEvento(evento: eventos[index]),
//                       ),
//                     );
//                   },
//                   child: Card(
//                     child: Row(
//                       children: <Widget>[
//                         // Mostrar la imagen del evento
//                         Image.file(
//                             File(eventos[index].photo?.toString() ?? '')),

//                         // Mostrar el título del evento
//                         Text(eventos[index].title),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Text('Error al obtener los eventos');
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:examen_2_emergency_app/database/db.dart'; // Importar las funciones de la BD
import 'package:examen_2_emergency_app/database/evento.dart'; // Importar la clase Evento
import 'package:flutter/material.dart';

import 'DetalleEvento.dart';
import 'EditarEvento.dart';

class EventosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Eventos')),
      body: FutureBuilder<List<Evento>>(
        future: DB.getAllEvents(), // Obtener los eventos
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final eventos = snapshot.data!;
            return ListView.builder(
              itemCount: eventos.length,
              itemBuilder: (context, index) {
                final evento = eventos[index];
                return ListTile(
                  title: Text(evento.title),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Navegar a la página de edición pasando el evento como parámetro
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditarEvento(evento: evento),
                        ),
                      );
                    },
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalleEvento(evento: evento),
                    ),
                  ),
                );
              },
            );
          }
          // SI DA ERROR PUES ESTO

          else if (snapshot.hasError) {
            // Imprimir el error en la consola
            print('Error al obtener los eventos: ${snapshot.error}');
            return Center(
                child: Text(
                    'Error al cargar los eventos')); // Mostrar un mensaje al usuario
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
