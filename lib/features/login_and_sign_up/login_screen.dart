
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/routes/routes.dart';

import '../../components/constants/text_style.dart';
import '../../components/custom_widgets/custom_app_bar.dart';
import '../../components/custom_widgets/custom_label_field.dart';
import '../../components/custom_widgets/custom_snackbar.dart';
import '../../controller/login_sign_up_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginAndSignUpController controller =
      Get.put(LoginAndSignUpController(), permanent: true);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Login Screen"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
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
              ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (formKey.currentState!.validate()) {
                    var temp = controller.callLogin();

                    if (temp == null) {
                      Get.offAllNamed(RouteNames.home);
                    } else {
                      CustomSnackBar.showCustomToast(message: temp);
                    }
                  }
                },
                child: Text("Submit", style: GetTextStyleTask.styleS20w700Black),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  Get.toNamed(RouteNames.signUp);
                },
                child: Text(
                  "SignUp",
                  style: GetTextStyleTask.styleS20w700Black.copyWith(
                    color: Colors.blueAccent,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
