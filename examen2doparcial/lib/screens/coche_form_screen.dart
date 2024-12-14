import 'package:flutter/material.dart';
import '../blocs/coche_bloc.dart';
import '../models/coche.dart';

class CocheFormScreen extends StatefulWidget {
  @override
  _CocheFormScreenState createState() => _CocheFormScreenState();
}

class _CocheFormScreenState extends State<CocheFormScreen> {
  final CocheBloc _cocheBloc = CocheBloc();
  final _formKey = GlobalKey<FormState>();
  String? _modelo;
  int? _anio;
  double? _precio;
  bool _disponible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Coche'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Usuario: ${_cocheBloc.getCurrentUserEmail() ?? ""}'),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Modelo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el modelo';
                  }
                  return null;
                },
                onSaved: (value) => _modelo = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Año'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el año';
                  }
                  return null;
                },
                onSaved: (value) => _anio = int.tryParse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el precio';
                  }
                  return null;
                },
                onSaved: (value) => _precio = double.tryParse(value!),
              ),
              SwitchListTile(
                title: Text('Disponible'),
                value: _disponible,
                onChanged: (bool value) {
                  setState(() {
                    _disponible = value;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Guardar'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newCoche = Coche(
                      id: '',
                      modelo: _modelo!,
                      anio: _anio!,
                      precio: _precio!,
                      disponible: _disponible,
                    );
                    _cocheBloc.addCoche(newCoche);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

