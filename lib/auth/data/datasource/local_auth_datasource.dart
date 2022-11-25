import 'package:get_storage/get_storage.dart';

abstract class BaseLocalAuthDatasource {
  void writeIsLogin({bool isLogin = false});
  bool readIsLogin();
  void writeUserId(int id);
  int readUserId();
  void writeToken(String token);
  String readToken();
}

class LocalAuthDatasource extends BaseLocalAuthDatasource {
  final box = GetStorage();
  @override
  void writeIsLogin({bool isLogin = false}) {
    box.write('isLogin', isLogin);
  }

  @override
  bool readIsLogin() => box.read('isLogin') ?? false;

  @override
  void writeUserId(int id) {
    box.write('userId', id);
  }

  @override
  int readUserId() => box.read('userId') ?? 0;

  @override
  void writeToken(String token) {
    box.write('token', token);
  }

  @override
  String readToken() => box.read('token') ?? '';
}
