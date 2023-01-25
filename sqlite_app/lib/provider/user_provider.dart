import 'package:flutter/cupertino.dart';
import 'package:sqlite_app/database/database.dart';
import 'package:sqlite_app/model/user.dart';

class UserProvider with ChangeNotifier {
  late List<User> _items = [];

  List<User> get users => _items;

  int get usersCount {
    return _items.length;
  }

  User itemByIndex(int index) {
    return _items[index];
  }

  Future<void> loadUser() async {
    final dataList = await DBUser.db.getData('user');
    _items = dataList.map((item) => User(name: item['name'])).toList();

    notifyListeners();
  }

  Future<void> addUser(String name) async {
    final newUser = User(name: name);

    await DBUser.db.insert('user', {'name': newUser.name});
  }

  Future<void> editUser(String name, int pos) async {
    final user = User(name: name);
    
    await DBUser.db.update('user', _items.elementAt(pos).name, {'name': user.name});
  }

  Future<void> deleteUser(String name) async {
    await DBUser.db.delete('user', name);
    _items.removeWhere((element) => element.name == name);
    notifyListeners();
  }
}
