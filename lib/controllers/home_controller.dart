import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

User? user = FirebaseAuth.instance.currentUser;

class HomeContoller extends GetxController {
  RxBool switch_1 = false.obs;
  RxBool switch_2 = false.obs;
  RxBool switch_3 = false.obs;
  RxBool switch_4 = false.obs;
  RxBool switch_5 = false.obs;
  int state;
  HomeContoller(this.state);

  final uref =
      FirebaseDatabase.instance.ref("iot_m/${user!.uid}").child('userName');
  //var userName = uref.onValue;

  Future<dynamic> getCurrentUserInfo() async {
    final ref = FirebaseDatabase.instance.ref("iot_m/${user!.uid}/iot");
    DatabaseEvent? event = await ref.once();
    log(event.snapshot.value.toString());

    Map iot = event.snapshot.value as Map;
    log(iot['IoT Switch 1']);
    log(iot['IoT Switch 2']);
    log(iot['IoT Switch 3']);
    log(iot['IoT Switch 4']);
    log(iot['IoT Switch 5']);

    iot['IoT Switch 1'].toString() == 'true'
        ? switch_1.value = true
        : switch_1.value = false;
    iot['IoT Switch 2'].toString() == 'true'
        ? switch_2.value = true
        : switch_2.value = false;
    iot['IoT Switch 3'].toString() == 'true'
        ? switch_3.value = true
        : switch_3.value = false;
    iot['IoT Switch 4'].toString() == 'true'
        ? switch_4.value = true
        : switch_4.value = false;
    iot['IoT Switch 5'].toString() == 'true'
        ? switch_5.value = true
        : switch_5.value = false;
    state == 0 ? Get.back() : null;
  }

  @override
  void onInit() {
    getCurrentUserInfo();
    super.onInit();
  }
}
