import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_mobil/views/user_operations/register_screen.dart';
import 'package:iot_mobil/controllers/user_operations_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 0, 53, 96),
            Color.fromARGB(255, 3, 116, 208)
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
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 18.0),
                      languageButtonWidget(),
                      const SizedBox(height: 30.0),
                      loginPageIcon(),
                      const SizedBox(height: 50.0),
                      helloAgainText(),
                      const SizedBox(height: 50.0),
                      emailField(),
                      const SizedBox(height: 10.0),
                      passwordField(),
                      const SizedBox(height: 10.0),
                      authErrorMessage(),
                      const SizedBox(height: 20.0),
                      loginButton(),
                      const SizedBox(height: 30.0),
                      registerNowText(),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row languageButtonWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Get.updateLocale(
              Get.locale == const Locale('en', 'US')
                  ? const Locale('tr', 'TR')
                  : const Locale('en', 'US'),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: const Color.fromARGB(135, 159, 159, 159),
                borderRadius: BorderRadius.circular(15.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.language,
                  color: Color.fromARGB(211, 0, 0, 0),
                  size: 18.0,
                ),
                const SizedBox(width: 3.0),
                Text(
                  Get.locale == const Locale('en', 'US') ? 'TR' : 'EN',
                  style: const TextStyle(
                    fontSize: 17.0,
                    fontFamily: 'comic-sans',
                    color: Color.fromARGB(211, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  loginPageIcon() {
    return Image.asset(
      'assets/images/playstore.png',
      width: 80.0,
    );
  }

  Text helloAgainText() {
    return Text(
      'HELLO AGAIN!'.tr,
      style: const TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w600,
        fontFamily: 'Comic Sans',
      ),
    );
  }

  emailField() {
    return TextFormField(
      controller: userController.loginEmailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) return ('Please Enter Your Email'.tr);
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.mail),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Email'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  bool obsController = true;
  passwordField() {
    return TextFormField(
      controller: userController.loginPasswordController,
      obscureText: obsController,
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value!.isEmpty) return ('Please Enter Your Password'.tr);
        if (value.length < 6) {
          return ('Enter Valid Password(Min. 6 Character)'.tr);
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key),
        suffixIcon: IconButton(
          icon: Icon(
            obsController != true ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            obsController == true
                ? setState(() {
                    obsController = false;
                  })
                : setState(() {
                    obsController = true;
                  });
          },
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Password'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  Obx authErrorMessage() => Obx(
        () => Text(
          userController.authMessage.value,
          style: TextStyle(
            color: Colors.blue[900],
          ),
        ),
      );

  loginButton() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(8.0), // 30.0
      color: Colors.blueAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            userController.singIn();
          }
        },
        child: Text(
          'Login'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  registerNowText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Not a member?  '.tr,
          style: const TextStyle(fontSize: 15, fontFamily: 'comic-sans'),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => const RegisterPage());
          },
          child: Text(
            'Register Now'.tr,
            style: const TextStyle(
                fontSize: 15,
                fontFamily: 'comic-sans',
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
