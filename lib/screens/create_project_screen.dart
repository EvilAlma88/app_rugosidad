import 'package:flutter/material.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  void _startCalibration() {
    if (_formKey.currentState!.validate()) {
      final String projectName = _nameController.text;
      final String projectDesc = _descController.text;

      // Aquí puedes guardar el proyecto en alguna lista o base de datos local
      
      Navigator.pushNamed(context, '/calibrate');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Proyecto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del proyecto',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingresa un nombre' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Descripción (opcional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _startCalibration,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Iniciar Calibración'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
