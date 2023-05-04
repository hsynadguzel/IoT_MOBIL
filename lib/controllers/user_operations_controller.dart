import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_mobil/const/loading_widget.dart';
import 'package:iot_mobil/models/user_model.dart';
import 'package:iot_mobil/views/home_screen/home_screen.dart';
import 'package:iot_mobil/views/user_operations/login_screen.dart';

class UserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref("iot_m");
  RxString authMessage = ''.obs;
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // giriş yap fonksiyonu
  Future<User?> singIn() async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: loginEmailController.text,
          password: loginPasswordController.text);
      /*  Get.snackbar(
        'Information'.tr,
        'Login Successful'.tr,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
      ); */ //get.dialogu engellediği için kaldırdım. satır 35,36,37
      Get.off(() => const HomeScreen());
      Get.dialog(
        const CustomLoadingWidget(),
      );
      return user.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        authMessage.value = 'User Not Found'.tr;
        return null;
      } else if (e.code == 'wrong-password') {
        authMessage.value = 'Wrong Password'.tr;
        return null;
      } else {
        return null;
      }
    }
  }

  // çıkış yap fonksiyonu
  singOut() async {
    return await _auth.signOut();
  }

  // kayıt ol fonksiyonu
  Future<User?> createPerson() async {
    emailController.text = emailController.text.toString().replaceAll(' ', '');
    UserModel userMap = UserModel(
      firstNameController.text,
      lastNameController.text,
      emailController.text,
      passwordController.text,
    );
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      await ref.child(user.user!.uid).set(userMap.toMap());
      Get.snackbar(
        'Information'.tr,
        'You Are Redirected To Successful Registration Page'.tr,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
      );
      Get.offAll(() => const LoginPage());
      return user.user;
    } on FirebaseDatabase catch (e) {
      Get.snackbar('ERROR DB', e.toString());
      return null;
    } catch (e) {
      Get.snackbar('ERROR', e.toString());
      return null;
    }
  }
}
