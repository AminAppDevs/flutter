import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/auth/domain/entities/user_exist.dart';
import 'package:jdolh_flutter/auth/domain/usecases/login_usecase.dart';
import 'package:jdolh_flutter/auth/domain/usecases/register_usecase.dart';
import 'package:jdolh_flutter/auth/domain/usecases/user_exist_usecase.dart';
import 'package:jdolh_flutter/core/error/failure.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/snackbar.dart';

class AuthController extends GetxController {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final UserExistUsecase userExistUsecase;
  AuthController(this.loginUsecase, this.registerUsecase, this.userExistUsecase);

  ///// properites
  bool isLoading = false;
  String phoneNumber = '';
  String fullName = '';

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  ///// login
  login(String phoneNumber) async {}

  ///// user exist
  checkUserExist({required String phoneNumber, required bool isLoginRequest}) async {
    isLoading = true;
    update();
    final Either<Failure, UserExist> result = await userExistUsecase(phoneNumber);

    result.fold((Failure failure) {
      isLoading = false;
      update();
    }, (UserExist userExist) {
      isLoading = false;
      update();
      if (userExist.isExist) {
        if (isLoginRequest) {
          print('login');
        } else {
          AppSnackbar.errorSnackbar(message: 'يوجد حساب مسبقاً بهذا الرقم، قم بتسجيل الدخول');
        }
      } else {
        if (isLoginRequest) {
          AppSnackbar.errorSnackbar(message: 'لا يوجد حساب بهذا الرقم، ادخل الرقم الصحيح او انشئ حساب جديد');
        } else {
          print('register');
        }
      }
    });
  }
}
