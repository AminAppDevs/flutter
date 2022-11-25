import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/core/services/service_locator.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controller/auth_controller.dart';

class PinScreen extends StatefulWidget {
  PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final AuthController authController = Get.put(AuthController(sl(), sl(), sl(), sl()));

  final pinForm = GlobalKey<FormState>();

  final TextEditingController pinController = TextEditingController();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (authController.remainingResendTime.value != 0) {
        authController.remainingResendTime.value--;
      } else {
        authController.enableResend.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vertical(70),
                SvgPicture.asset('assets/images/logo-color.svg', height: 35),
                vertical(15),
                Text('أدخل رمز', style: Theme.of(context).textTheme.headlineMedium),
                Text('التأكيد', style: Theme.of(context).textTheme.headlineMedium!.copyWith(height: 1)),
                vertical(10),
                line(60),
                vertical(20),
                Obx(
                  () => Text('أدخل رمز التأكيد المرسل إلى رقمك ${authController.phoneNumber}', style: Theme.of(context).textTheme.labelLarge),
                ),
                Form(
                  key: pinForm,
                  child: Column(
                    children: [
                      vertical(10),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: PinCodeTextField(
                          appContext: context,
                          controller: pinController,
                          length: 6,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          autoDismissKeyboard: true,
                          backgroundColor: Colors.transparent,
                          keyboardType: TextInputType.number,
                          enableActiveFill: true,
                          textStyle: Theme.of(context).textTheme.headlineMedium,
                          errorTextDirection: TextDirection.rtl,
                          errorTextSpace: 30,
                          errorTextMargin: const EdgeInsets.all(0),
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            activeFillColor: AppLightColor.inputBgColor,
                            errorBorderColor: Colors.black,
                            disabledColor: Colors.white,
                            activeColor: AppLightColor.primaryColor,
                            fieldOuterPadding: const EdgeInsets.all(0),
                            inactiveColor: AppLightColor.inputBgColor,
                            inactiveFillColor: AppLightColor.inputBgColor,
                            selectedColor: AppLightColor.primaryColor,
                            selectedFillColor: AppLightColor.inputBgColor,
                            fieldHeight: 60,
                            fieldWidth: MediaQuery.of(context).size.width * .14,
                            borderWidth: 1,
                          ),
                          onChanged: (value) {},
                          validator: (value) {
                            if (value!.length != 6) {
                              return 'الرجاء ادخال الرمز 6 ارقام';
                            }
                            return null;
                          },
                        ),
                      ),
                      GetBuilder<AuthController>(builder: ((controller) {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (pinForm.currentState!.validate()) {
                                authController.verifyOtp(pinController.text);
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
                                : const Text('تأكيد'),
                          ),
                        );
                      })),
                      vertical(20),
                      Obx(
                        () => Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('يمكنك اعادة الارسال بعد ', style: Theme.of(context).textTheme.labelMedium),
                                Text(
                                  '${authController.remainingResendTime.value}',
                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppLightColor.primaryColor,
                                      ),
                                ),
                                Text(' ثانية', style: Theme.of(context).textTheme.labelMedium),
                              ],
                            ),
                            vertical(10),
                            if (authController.enableResend.value)
                              InkWell(
                                onTap: () {
                                  authController.remainingResendTime.value = 60;
                                  authController.enableResend.value = false;
                                  authController.phoneAuthentication(authController.phoneNumber.value);
                                },
                                child: Text(
                                  'اعادة ارسال الرمز',
                                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: AppLightColor.secondaryColor,
                                      ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
