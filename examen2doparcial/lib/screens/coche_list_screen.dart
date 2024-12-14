import 'package:flutter/material.dart';
import '../blocs/coche_bloc.dart';
import '../models/coche.dart';

class CocheListScreen extends StatefulWidget {
  @override
  _CocheListScreenState createState() => _CocheListScreenState();
}

class _CocheListScreenState extends State<CocheListScreen> {
  final CocheBloc _cocheBloc = CocheBloc();

  @override
  void initState() {
    super.initState();
    _cocheBloc.getCocheList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Coches'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Implement sign out logic here
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Coche>>(
        stream: _cocheBloc.cocheStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final coches = snapshot.data!;
            if (coches.isEmpty) {
              return Center(child: Text('No hay coches registrados.'));
            }
            return ListView.builder(
              itemCount: coches.length,
              itemBuilder: (context, index) {
                final coche = coches[index];
                return ListTile(
                  title: Text(coche.modelo),
                  subtitle: Text('Año: ${coche.anio}, Precio: \$${coche.precio}'),
                  trailing: Icon(
                    coche.disponible ? Icons.check_circle : Icons.cancel,
                    color: coche.disponible ? Colors.green : Colors.red,
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/coche_form');
        },
      ),
    );
  }

  @override
  void dispose() {
    _cocheBloc.dispose();
    super.dispose();
  }
}

