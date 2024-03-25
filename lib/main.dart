import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Import necessário para kIsWeb
import 'package:image_picker/image_picker.dart';
import 'login.dart';
import 'database_helper.dart';
import 'dart:typed_data';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário de Chamado de Manutenção',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MaintenanceForm(),
    );
  }
}

class MaintenanceForm extends StatefulWidget {
  @override
  _MaintenanceFormState createState() => _MaintenanceFormState();
}

class _MaintenanceFormState extends State<MaintenanceForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  XFile? _selectedImage;
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chamado de Manutenção',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Descrição do Chamado de Manutenção',
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Por favor, insira a descrição do chamado de manutenção.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Nome',
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Por favor, insira seu nome.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Por favor, insira seu email.';
                          } else if (!value!.contains('@')) {
                            return 'Email inválido.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: Text('Selecionar Imagem'),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() && _selectedImage != null) {
                            _submitForm();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Por favor, preencha todos os campos e selecione uma imagem.'),
                              ),
                            );
                          }
                        },
                        child: Text('Enviar'),
                      ),
                      SizedBox(height: 20.0),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                        icon: Icon(Icons.login),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                _selectedImage != null
                    ? kIsWeb
                    ? Image.network(_selectedImage!.path)
                    : Image.file(File(_selectedImage!.path))
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  void _submitForm() async {
    String description = _descriptionController.text;
    String name = _nameController.text;
    String email = _emailController.text;

    print('Descrição do Chamado: $description');
    print('Nome: $name');
    print('Email: $email');
    if (_selectedImage != null) {
      print('Caminho da Imagem: ${_selectedImage!.path}');
    }

    _descriptionController.clear();
    _nameController.clear();
    _emailController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Abertura de chamado realizada com sucesso'),
      ),
    );
  }
}
