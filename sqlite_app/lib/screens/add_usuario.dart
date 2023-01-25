import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_app/provider/user_provider.dart';
import 'package:sqlite_app/screens/lista_usuarios.dart';

class AddUsuario extends StatelessWidget {

  const AddUsuario({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();

    void add() {
      Provider.of<UserProvider>(context, listen: false).addUser(name.text);
      
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const ListaUsuarios()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Usuário'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(controller: name),
              ),
            ),

            ElevatedButton(
              onPressed: add,
              child: const Text('Adicionar Usuário'),
            ),

            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ListaUsuarios())),
              child: const Text('Ver lista'),
            ),
          ],
        ),
      ),
    );
  }
}