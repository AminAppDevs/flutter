import 'package:jdolh_flutter/auth/domain/repository/base_auth_repository.dart';

class LocalAuthUsecases {
  final BaseAuthRepository baseAuthRepository;

  LocalAuthUsecases(this.baseAuthRepository);

  void writeIsLogin(bool isLogin) {
    baseAuthRepository.writeIsLogin(isLogin);
  }

  bool readIsLogin() {
    return baseAuthRepository.readIsLogin();
  }

  void writeUserId(int id) {
    baseAuthRepository.writeUserId(id);
  }

  int readUserId() {
    return baseAuthRepository.readUserId();
  }

  void writeToken(String token) {
    baseAuthRepository.writeToken(token);
  }

  String readToken() {
    return baseAuthRepository.readToken();
  }
}
