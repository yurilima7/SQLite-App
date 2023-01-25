import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_app/model/arguments.dart';
import 'package:sqlite_app/provider/user_provider.dart';
import 'package:sqlite_app/screens/lista_usuarios.dart';

class UpdateUsuarios extends StatelessWidget {
  const UpdateUsuarios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Arguments args = ModalRoute.of(context)!.settings.arguments as Arguments;
    String name = args.name;
    int pos = args.pos;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  initialValue: args.name,
                  onSaved: (newValue) => name = newValue!,
                ),
              ),
            ),
            Consumer<UserProvider>(
              builder: (context, provider, child) => ElevatedButton(
                onPressed: () {
                  formKey.currentState?.save();
                  
                  provider.editUser(name, pos);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ListaUsuarios()));
                },
                child: const Text('Salvar Usuário'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
