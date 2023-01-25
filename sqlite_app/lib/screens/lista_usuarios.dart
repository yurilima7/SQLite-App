import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_app/model/arguments.dart';
import 'package:sqlite_app/provider/user_provider.dart';
import 'package:sqlite_app/screens/add_usuario.dart';

class ListaUsuarios extends StatelessWidget {
  const ListaUsuarios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nome'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const AddUsuario(),),
                (Route<dynamic> route) => false,
            ), 
            icon: const Icon(Icons.home),
          )
        ],
      ),

      body: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false).loadUser(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting

        ? const Center(child:  CircularProgressIndicator(),)
        : Consumer<UserProvider>(
            child: const Center(
              child: Text('Nenhum nome cadastrado'),
            ),

            builder: (context, provider, child) => provider.usersCount == 0
            ? child!
            : ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: provider.usersCount,
                itemBuilder: (context, index) => ListTile(
                trailing: IconButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              '/update',
                              arguments: Arguments(
                                name: provider.itemByIndex(index).name,
                                pos: index,
                              ),
                            ),
                    icon: const Icon(Icons.edit),
                  ),

                onLongPress: () => provider.deleteUser(
                  provider.itemByIndex(index).name,
                ),

                title: Text(provider.itemByIndex(index).name),
              ),
            )
          ),    
      ),
    );
  }
}
