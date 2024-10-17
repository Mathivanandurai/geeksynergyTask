import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:task/routes/routes.dart';

import '../../components/constants/text_style.dart';
import '../../components/custom_widgets/custom_app_bar.dart';
import '../../components/custom_widgets/custom_label_field.dart';
import '../../components/custom_widgets/custom_snackbar.dart';
import '../../controller/login_sign_up_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  LoginAndSignUpController controller = Get.find();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Display dialog after UI has rerendered
      controller.callReset();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (s) {
        controller.callReset();
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Signup Screen",
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(
                  height: 20,
                ),
                CustomLabelField(
                  title: "Name",
                  child: TextFormField(
                    controller: controller.name,
                    validator: controller.nameValidator,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomLabelField(
                  title: "Password",
                  child: TextFormField(
                    obscureText: true,
                    controller: controller.password,
                    validator: controller.passwordValidator,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomLabelField(
                  title: "Email",
                  child: TextFormField(
                    controller: controller.email,
                    validator: controller.emailValidator,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomLabelField(
                  title: "Phone number",
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                    keyboardType: TextInputType.number,
                    controller: controller.phone,
                    validator: controller.phoneValidator,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GetBuilder<LoginAndSignUpController>(
                  builder: (context) {
                    return CustomLabelField(
                      title: "Profession",
                      child: _buildProfessionDropDown(),
                    );
                  }
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        var temp = await controller.callSignUp();
                        if (temp == null) {
                          Get.offAllNamed(RouteNames.home);
                        } else {
                          CustomSnackBar.showCustomToast(message: temp);
                        }
                      }
                    },
                    child: Text(
                      "Sign Up",
                      style: GetTextStyleTask.styleS20w700Black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildProfessionDropDown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.only(top: 5, bottom: 13, left: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: controller.professionValidator,
      dropdownColor: Colors.white,
      value: controller.profession,
      onChanged: (newValue) {
        controller.updateProfession(newValue);
      },
      items: controller.dropdownItems,
    );
  }
}
