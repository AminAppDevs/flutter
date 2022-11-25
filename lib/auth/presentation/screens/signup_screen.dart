import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jdolh_flutter/auth/presentation/controller/auth_controller.dart';
import 'package:jdolh_flutter/auth/presentation/screens/signin_screen.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final signupForm = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final AuthController authController = Get.find();

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
                Text('إنشاء حساب', style: Theme.of(context).textTheme.headlineMedium),
                Text('جديد', style: Theme.of(context).textTheme.headlineMedium!.copyWith(height: 1)),
                vertical(10),
                line(60),
                vertical(40),
                Form(
                  key: signupForm,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        onChanged: (value) {
                          authController.fullName.value = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'الرجاء كتابة اسمك بالكامل';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Ionicons.person_outline),
                          hintText: 'الإسم بالكامل',
                        ),
                      ),
                      vertical(6),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        onChanged: (value) {
                          authController.phoneNumber.value = value;
                        },
                        validator: (value) {
                          if (value!.length != 10) {
                            return 'الرجاء كتابة 10 ارقام';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Ionicons.phone_portrait_outline),
                          hintText: 'رقم الجوال (05xxxxxxxx)',
                          suffixIcon: Container(
                            width: 110,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(color: Colors.grey.shade200),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Ionicons.chevron_down, size: 16),
                                const Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text(
                                    '+966',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                horizontal(5),
                                SvgPicture.asset('assets/images/sa-flag.svg', height: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                      vertical(6),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (signupForm.currentState!.validate()) {
                              authController.isLoginRequest.value = false;
                              authController.checkUserExist(phoneNumber: phoneController.text, isLoginRequest: false);
                            }
                          },
                          child: GetBuilder<AuthController>(
                            builder: (controller) => controller.isLoading
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
                                : const Text('إنشاء'),
                          ),
                        ),
                      )
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
          onTap: () => Get.offAll(() => SigninScreen()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('لديك حساب بالفعل ؟', style: Theme.of(context).textTheme.labelLarge),
              Text(
                ' تسجيل دخول',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppLightColor.primaryColor, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
