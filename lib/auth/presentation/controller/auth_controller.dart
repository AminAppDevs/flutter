import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/auth/domain/entities/auth_result.dart';
import 'package:jdolh_flutter/auth/domain/entities/user_exist.dart';
import 'package:jdolh_flutter/auth/domain/usecases/local_auth_usecases.dart';
import 'package:jdolh_flutter/auth/domain/usecases/login_usecase.dart';
import 'package:jdolh_flutter/auth/domain/usecases/register_usecase.dart';
import 'package:jdolh_flutter/auth/domain/usecases/user_exist_usecase.dart';
import 'package:jdolh_flutter/auth/presentation/screens/pin_screen.dart';
import 'package:jdolh_flutter/core/error/failure.dart';
import 'package:jdolh_flutter/core/utils/snackbar.dart';
import 'package:jdolh_flutter/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:platform_device_id/platform_device_id.dart';

class AuthController extends GetxController {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final UserExistUsecase userExistUsecase;
  final LocalAuthUsecases localAuthUsecases;
  AuthController(this.loginUsecase, this.registerUsecase, this.userExistUsecase, this.localAuthUsecases);

  ///// properites
  bool isLoading = false;
  RxString phoneNumber = ''.obs;
  RxString fullName = ''.obs;
  final auth = FirebaseAuth.instance;
  RxString verificationId = ''.obs;
  RxBool isLoginRequest = true.obs;
  RxInt remainingResendTime = 60.obs;
  RxBool enableResend = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  ///// login
  login(String phoneNumber) async {
    isLoading = true;
    update();
    String? deviceId = await PlatformDeviceId.getDeviceId;
    print('$deviceId bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');
    Either<Failure, AuthResult> result = await loginUsecase(phoneNumber, deviceId!);
    result.fold((Failure failure) {
      AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
      isLoading = false;
      update();
    }, (AuthResult authResult) {
      isLoading = false;
      update();
      localAuthUsecases.writeIsLogin(true);
      localAuthUsecases.writeUserId(authResult.userId);
      localAuthUsecases.writeToken(authResult.token);
      Get.to(() => DashboardScreen());
    });
  }

  ///// register
  register(String phoneNumber, String fullName) async {
    isLoading = true;
    update();
    String? deviceId = await PlatformDeviceId.getDeviceId;
    print('$deviceId bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');
    Either<Failure, AuthResult> result = await registerUsecase(phoneNumber, fullName, deviceId!);
    result.fold((Failure failure) {
      AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
      isLoading = false;
      update();
    }, (AuthResult authResult) {
      isLoading = false;
      update();
      localAuthUsecases.writeIsLogin(true);
      localAuthUsecases.writeUserId(authResult.userId);
      localAuthUsecases.writeToken(authResult.token);
      Get.to(() => DashboardScreen());
    });
  }

  ///// user exist
  checkUserExist({required String phoneNumber, required bool isLoginRequest}) async {
    isLoading = true;
    update();
    final Either<Failure, UserExist> result = await userExistUsecase(phoneNumber);

    result.fold((Failure failure) {
      isLoading = false;
      update();
      AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما الرجاء المحاولة مرة آخرى');
    }, (UserExist userExist) {
      isLoading = false;
      update();
      print(userExist);
      if (userExist.isExist) {
        if (isLoginRequest) {
          phoneAuthentication(phoneNumber.trim());
        } else {
          AppSnackbar.errorSnackbar(message: 'يوجد حساب مسبقاً بهذا الرقم، قم بتسجيل الدخول');
        }
      } else {
        if (isLoginRequest) {
          AppSnackbar.errorSnackbar(message: 'لا يوجد حساب بهذا الرقم، ادخل الرقم الصحيح او انشئ حساب جديد');
        } else {
          phoneAuthentication(phoneNumber.trim());
        }
      }
    });
  }

  ///// phone authentication
  Future<void> phoneAuthentication(String phoneNumber) async {
    isLoading = true;
    update();
    await auth.verifyPhoneNumber(
      phoneNumber: '+966$phoneNumber',
      verificationCompleted: (credential) async {
        await auth.signInWithCredential(credential);
        isLoading = false;
        update();
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
        this.phoneNumber.value = phoneNumber;
        Get.to(() => PinScreen());
        isLoading = false;
        update();
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
        isLoading = false;
        update();
      },
      verificationFailed: (e) {
        isLoading = false;
        update();
        if (e.code == 'invalid-phone-number') {
          AppSnackbar.errorSnackbar(message: 'الرجاء ادخال رقم هاتف صحيح');
        } else {
          AppSnackbar.errorSnackbar(message: 'يوجد خطأ ما، الرجاء المحاولة مرة أخرى');
        }
      },
      timeout: const Duration(seconds: 3),
    );
  }

  ///// verify otp
  verifyOtp(String otp) async {
    isLoading = true;
    update();
    await auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: otp)).then((value) {
      isLoading = false;
      update();

      print(value);

      if (isLoginRequest.value) {
        login(phoneNumber.value);
      } else {
        register(phoneNumber.value, fullName.value);
      }
    }).catchError((e) {
      print('xxxxxxxxxxxxxxxxxx: $e');
      isLoading = false;
      update();
      AppSnackbar.errorSnackbar(message: 'الرمز المدخل غير صحيح، أو انتهت صلاحيته');
    });
  }
}
