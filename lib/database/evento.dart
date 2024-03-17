class Evento {
  // Caracteristicas / Propiedades
  int? id;
  String title;
  String description;
  DateTime? date;
  String? photo;

  //constructor
  Evento(
      {this.id,
      required this.title,
      required this.description,
      this.date,
      this.photo});

// la función toMap() toma un objeto de una clase y lo convierte en un mapa que puede ser fácilmente almacenado en una base de datos, lo que facilita su inserción, actualización o consulta.
  // Map<String, dynamic> toMap() {
  //   return {
  //     "id": id,
  //     "title": title,
  //     "description": description,
  //     "date": date,
  //     "photo": photo
  //   };
  // }
  Map<String, dynamic> toMap() {
    final map = {
      "id": id,
      "title": title,
      "description": description,
      "photo": photo
    };
    if (date != null) {
      map["date"] = date.toString();
    } else {
      date = DateTime.now();
      map["date"] = date.toString();
    }

    return map;
  }
}
