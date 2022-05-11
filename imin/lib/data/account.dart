import 'package:imin/models/account_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Account {
  Future getDatabase() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'account_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE account(id INTEGER PRIMARY KEY, username TEXT, password TEXT)',
        );
      },
      version: 1,
    );

    return database;
  }

  Future initAccount() async {
    final db = await getDatabase();

    var result = await accounts();

    if (result.isNotEmpty) {
      return;
    }

    var data = const AccountModel(
      id: 1,
      username: '',
      password: '',
    );

    await db.insert(
      'account',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAccount(AccountModel account) async {
    final db = await getDatabase();

    await db.insert(
      'account',
      account.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<AccountModel>> accounts() async {
    final db = await getDatabase();

    final List<Map<String, dynamic>> maps = await db.query('account');

    return List.generate(maps.length, (i) {
      return AccountModel(
        id: maps[i]['id'],
        username: maps[i]['username'],
        password: maps[i]['password'],
      );
    });
  }

  Future<void> updateAccount(AccountModel account) async {
    final db = await getDatabase();

    await db.update(
      'account',
      account.toMap(),
      where: 'id = ?',
      whereArgs: [account.id],
    );
  }

  Future<void> deleteAccount(int id) async {
    final db = await getDatabase();

    await db.delete(
      'account',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  void test() async {
    // --------- Test ------------------------
    var data = const AccountModel(
      id: 1,
      username: 'user',
      password: 'password',
    );

    // insert
    // await insertAccount(peet);
    // print(await accounts());

    // update
    data = const AccountModel(
      id: 1,
      username: 'admin',
      password: 'secret',
    );
    // await updateAccount(peet);
    // print(await accounts());

    // await deleteAccount(1);
    print(await accounts());

    // --------- End Test --------------------
  }
}
