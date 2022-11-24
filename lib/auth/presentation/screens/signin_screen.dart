import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/auth/presentation/controller/auth_controller.dart';
import 'package:jdolh_flutter/auth/presentation/screens/signup_screen.dart';
import 'package:jdolh_flutter/core/services/service_locator.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});
  final loginForm = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final AuthController authController = Get.put(AuthController(sl(), sl(), sl()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vertical(70),
                SvgPicture.asset('assets/images/logo-color.svg', height: 35),
                vertical(15),
                Text('تسجيل الدخول ', style: Theme.of(context).textTheme.headlineMedium),
                Text('لحسابك', style: Theme.of(context).textTheme.headlineMedium!.copyWith(height: 1)),
                vertical(10),
                line(60),
                vertical(40),
                Form(
                  key: loginForm,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          authController.phoneNumber = value;
                        },
                        validator: ((value) {
                          if (value!.length != 10) {
                            return 'الرجاء ادخال رقم هاتف صالح';
                          }
                          return null;
                        }),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Ionicons.phone_portrait_outline),
                          hintText: 'رقم الجوال الخاص بك',
                        ),
                      ),
                      vertical(10),
                      GetBuilder<AuthController>(builder: ((controller) {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (loginForm.currentState!.validate()) {
                                authController.checkUserExist(phoneNumber: phoneController.text, isLoginRequest: true);
                              }
                            },
                            child: controller.isLoading
                                ? Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      width: 29,
                                      height: 29,
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  )
                                : const Text('دخول'),
                          ),
                        );
                      })),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.white,
        alignment: Alignment.topCenter,
        child: InkWell(
          onTap: () => Get.offAll(() => SignupScreen()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ليس لديك حساب؟ ', style: Theme.of(context).textTheme.labelLarge),
              Text(
                'إنشاء حساب',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppLightColor.primaryColor, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
