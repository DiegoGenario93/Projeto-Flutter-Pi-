import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models.dart';
//import 'package:path_provider/path_provider.dart';

class ServicoPage extends StatefulWidget {
  @override
  _ServicoPageState createState() => _ServicoPageState();
}

class _ServicoPageState extends State<ServicoPage> {
  List<MaintenanceForm> _forms = [];

  @override
  void initState() {
    super.initState();
    _getFormsFromDatabase(); // Chama a função para obter os formulários do banco de dados ao iniciar a página
  }

  Future<void> _getFormsFromDatabase() async {
    print("Chamando _getFormsFromDatabase()");
    try {
      DatabaseHelper dbHelper = DatabaseHelper();
      List<MaintenanceForm> forms = await dbHelper.getForms();
      print("Forms recuperados do banco de dados: $forms");
      setState(() {
        _forms = forms;
      });
    } catch (e) {
      print("Erro ao recuperar formulários do banco de dados: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Construindo a página de Serviço");
    return Scaffold(
      appBar: AppBar(
        title: Text('Listagem de Chamados'),
      ),
      body: _buildFormsList(),
    );
  }

  Widget _buildFormsList() {
    print("Construindo a lista de formulários");
    return _forms.isEmpty
        ? Center(child: CircularProgressIndicator()) // Exibe um indicador de carregamento enquanto os dados estão sendo carregados
        : ListView.builder(
      itemCount: _forms.length,
      itemBuilder: (context, index) {
        MaintenanceForm form = _forms[index];
        return ListTile(
          title: Text(form.description ?? ''), // Exibe a descrição do formulário
          subtitle: Text('${form.name}, ${form.email}'), // Exibe o nome e o email do formulário
        );
      },
    );
  }
}

