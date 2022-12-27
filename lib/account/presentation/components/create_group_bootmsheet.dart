import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_flutter/account/presentation/controller/account_controller.dart';
import 'package:jdolh_flutter/core/utils/app_light_color.dart';
import 'package:jdolh_flutter/core/utils/global_utils.dart';

Container createGroupBootmsheet(BuildContext context) {
  final groupForm = GlobalKey<FormState>();
  final TextEditingController groupNameController = TextEditingController();
  return Container(
    height: 300,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('انشاء مجموعة', style: Theme.of(context).textTheme.titleLarge),
        vertical(10),
        Form(
          key: groupForm,
          child: GetBuilder<AccountController>(
            builder: (controller) => controller.isCreateGroupLoading
                ? Center(
                    child: SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        color: AppLightColor.primaryColor,
                        strokeWidth: 3,
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView(
                      children: [
                        TextFormField(
                          controller: groupNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'الحقل فارغ';
                            }
                            return null;
                          },
                          decoration:
                              InputDecoration(hintText: 'اسم المجموعة', contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17)),
                        ),
                        vertical(10),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (groupForm.currentState!.validate()) {
                                print(groupNameController.text);
                                controller.createGroup(groupNameController.text);
                              }
                            },
                            child: Text('انشاء'),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    ),
  );
}
