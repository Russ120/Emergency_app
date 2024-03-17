// ignore_for_file: unused_element, unused_local_variable, avoid_print, prefer_interpolation_to_compose_strings

import 'package:examen_2_emergency_app/database/evento.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  // CONEXION A LA DB
  // las funcione estaticas no se pueden instancear asi que se ejecuta el patron singleton, esto devolverá un future de database es asincrona
  static Future<Database> _openDB() async {
    try {
      // el getDatabasesPath devuelve la ruta donde se almacena la bd de la app
      // y la concatena con el nombre del fichero donde voy a almacenar esos datos
      return openDatabase(join(await getDatabasesPath(), 'eventos.db'),
          //este metodo es para decir que si no esta creada la base de datos se ejetara la primera ves esto
          onCreate: (db, version) {
        db.execute('''CREATE TABLE eventos (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT NOT NULL,
              description TEXT NOT NULL,
              date TEXT NOT NULL,
              photo TEXT)''');
      },
          // Aqui se define la version para que luego pueda hacer otra operacion y aqui le digo que esta será la uno
          version: 1);
    } catch (e) {
      // Manejar la excepción según sea necesario
      print('Error al abrir la base de datos: $e');
      rethrow; // Opcionalmente, puedes lanzar la excepción nuevamente
    }
  }

// AÑADIR
// Estatica para que no sea instanceada void por que no devuelve nada, recibe tipo Evento y es asincrona
  static Future<void> insert(Evento evento) async {
    try {
      // establezco la conexion con la db
      Database database = await _openDB();

      // puesto por mi por que se supone que no devuelve nada y el pana pudo un return
      database.insert("eventos", evento.toMap());

      // Da error por que no debe retornar nada
      // return database.insert("eventos", evento.toMap());
    } catch (e) {
      print('Error al insertar en la base de datos: $e');
      rethrow;
    }
  }

// ELIMINAR
  static Future<void> delete(Evento evento) async {
    try {
      // establezco la conexion con la db
      Database database = await _openDB();

      // se busca el metodo eliminar de la db y se le dice en que tabla y luego la condicion esta tiene un formato de insercion de interpolacion en un string por eso el whereArgs
      database.delete("eventos", where: "id = ?", whereArgs: [evento.id]);

      // linea del tutorial pero no debe retornar nada
      // return database.delete("evento", where: "id = ?", whereArgs: [evento.id]);
    } catch (e) {
      print('Error al eliminando en la base de datos: $e');
      rethrow;
    }
  }

// ACTUALIZAR
  static Future<void> update(Evento evento) async {
    try {
      // establezco la conexion con la db
      Database database = await _openDB();

      // aqui se le manda la tabla, el cuerpo en tomap, luego la condicion y seguido de el valor del signo de la condicion
      database.update("eventos", evento.toMap(),
          where: "id = ?", whereArgs: [evento.id]);
      // return database.update("evento", evento.toMap(), where: "id = ?", whereArgs: [evento.id] );
    } catch (e) {
      print('Error al actualizar en la base de datos: $e');
      rethrow;
    }
  }

// OBETENR TODOS
  static Future<List<Evento>> getAllEvents() async {
    try {
      // establezco la conexion con la db
      Database database = await _openDB();

      // esto nos devuelve todos los registros de la tabla eventos, se le iguala a la variable eventosMap
      // quien atrapará lo que devuelva el query, final por que no se va a modificar posteriormente
      final List<Map<String, dynamic>> eventosMap =
          await database.query("eventos");

      // convertir el tipo de eventosMap List<Map<String, dynamic>> a el de eventos con sus propiedades y todo eso
      return List.generate(
          eventosMap.length,
          (index) => Evento(
              // aqui es como un mapeo, igualando las prop de este eventMap al de un objeto de Eventos
              // por eso se usa la posicion del index y el siguiente corchete es para  acceder a cada una de las columnas especificas
              id: eventosMap[index]['id'],
              title: eventosMap[index]['title'],
              description: eventosMap[index]['description'],
              // date: eventosMap[index]['date'],
              // Convertir la fecha solo si no es null
              date: eventosMap[index]['date'] != null
                  ? DateTime.parse(eventosMap[index]['date'])
                  : null,
              photo: eventosMap[index]['photo']));
    } catch (e) {
      print('Error al obtener todos los eventos: $e');
      rethrow;
    }
  }
}
