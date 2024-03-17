// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'Portada.dart';
import 'RegistrarEventos.dart';
import 'TodosLosEventos.dart';

class MenuPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Cierra el teclado cuando se toca fuera del campo de entrada
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: DefaultTabController(
        length: 3, // Número de pestañas
        child: Scaffold(
          appBar: AppBar(
            title: Text('Emergency app'),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  // text: 'Inicio',
                ),
                Tab(text: 'Nuevo Evento'),
                Tab(text: 'Eventos'),
              ],
            ),
          ),
          body: TabBarView(
            children: [WelcomePage(), NuevoEventoForm(), EventosPage()],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => MenuPages(),
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// import 'Portada.dart';
// import 'RegistrarEventos.dart';
// import 'TodosLosEventos.dart';

// class MenuPages extends StatefulWidget {
//   @override
//   _MenuPagesState createState() => _MenuPagesState();
// }

// class _MenuPagesState extends State<MenuPages>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//     _tabController.addListener(_handleTabChange);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   void _handleTabChange() {
//     // Cierra el teclado cuando se cambia de pestaña
//     FocusScope.of(context).unfocus();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Cierra el teclado cuando se toca fuera del campo de entrada
//         FocusScope.of(context).unfocus();
//       },
//       child: DefaultTabController(
//         length: 3, // Número de pestañas
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text('Emergency app'),
//             bottom: TabBar(
//               controller: _tabController,
//               tabs: [
//                 Tab(
//                   icon: Icon(Icons.home),
//                   // text: 'Inicio',
//                 ),
//                 Tab(text: 'Nuevo Evento'),
//                 Tab(text: 'Eventos'),
//               ],
//             ),
//           ),
//           body: TabBarView(
//             controller: _tabController,
//             children: [WelcomePage(), NuevoEventoForm(), EventosPage()],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Navigator(
//         onGenerateRoute: (settings) {
//           return MaterialPageRoute(
//             builder: (context) => MenuPages(),
//           );
//         },
//       ),
//     );
//   }
// }
