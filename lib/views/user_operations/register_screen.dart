import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_mobil/controllers/user_operations_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final registerController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 0, 53, 96),
            Color.fromARGB(255, 3, 116, 208),
            Color.fromARGB(255, 0, 53, 96)
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(251, 255, 255, 255),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    registerPageIcon(),
                    const SizedBox(height: 28.0),
                    firstNameField(),
                    const SizedBox(height: 12.0),
                    lastNameField(),
                    const SizedBox(height: 12.0),
                    emailField(),
                    const SizedBox(height: 12.0),
                    passwordField(),
                    const SizedBox(height: 12.0),
                    confirmPasswordField(),
                    const SizedBox(height: 18.0),
                    registerButton(),
                    const SizedBox(height: 18.0),
                    noteText()
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }

  Icon registerPageIcon() {
    return const Icon(
      Icons.app_registration_rounded,
      size: 90.0,
    );
  }

  firstNameField() {
    return TextFormField(
      controller: registerController.firstNameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) return ("First Name cannot be Empty".tr);
        if (value.length < 3) return ("Enter Valid name(Min. 3 Character)".tr);
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_circle),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'First Name'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  lastNameField() {
    return TextFormField(
      controller: registerController.lastNameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) return ("Second Name cannot be Empty".tr);
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.account_circle),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Last Name'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  emailField() {
    return TextFormField(
      controller: registerController.emailController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) return ("Please Enter Your Email".tr);
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Email'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  passwordField() {
    return TextFormField(
      controller: registerController.passwordController,
      obscureText: true,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) return ("Password is required for login".tr);
        if (value.length < 6) {
          return ("Enter Valid Password(Min. 6 Character)".tr);
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Password'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  confirmPasswordField() {
    return TextFormField(
      controller: registerController.confirmPasswordController,
      obscureText: true,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (registerController.passwordController.value !=
            registerController.confirmPasswordController.value) {
          return "Password don't match !".tr;
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Confirm Password'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  registerButton() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(8.0), // 30.0
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            registerController.createPerson();
          }
        },
        child: Text(
          'Register'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  noteText() {
    return RichText(
      text: TextSpan(
        text: 'Note:'.tr,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: ' Fill in the fields completely!'.tr,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
