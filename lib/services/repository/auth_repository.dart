import 'package:getit/data/model/user.dart';
import 'package:getit/services/helper/database_helper.dart';

class AuthRepository {
  final DatabaseHelper databaseHelper;

  AuthRepository({required this.databaseHelper});

  Future<User?> login(String email, String password) async {
    return await databaseHelper.getUser(email, password);
  }

  Future<void> register(String username, String email, String password) async {
    final user = User(username: username, email: email, password: password);
    await databaseHelper.insertUser(user);
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await databaseHelper.database;
    final maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }
}
