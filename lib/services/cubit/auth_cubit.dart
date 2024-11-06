import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getit/services/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/user.dart';

class AuthCubit extends Cubit<User?> {
  final AuthRepository authRepository;
  final SharedPreferences prefs;

  AuthCubit(this.authRepository, this.prefs) : super(null) {
    initializeUser();
  }

  Future<void> initializeUser() async {
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      final email = prefs.getString('email');
      if (email != null) {
        final user = await authRepository.getUserByEmail(email);
        if (user != null) {
          emit(user);
        }
      }
    }
  }

  Future<bool> login(String email, String password) async {
    final user = await authRepository.login(email, password);
    if (user != null) {
      emit(user);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('email', email);
      return true;
    }
    return false;
  }

  Future<bool> register(String username, String email, String password) async {
    try {
      await authRepository.register(username, email, password);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    emit(null);
  }

  User? getDataUser() {
    return state;
  }

  Future<void> updateUserData(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await prefs.setString('username', name);
    await prefs.setString('email', email);

    emit(User(username: name, email: email));
  }
}
