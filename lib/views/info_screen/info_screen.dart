import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iot_mobil/const/bottom_text.dart';
import 'package:iot_mobil/controllers/home_controller.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

// class dışı
User? user = FirebaseAuth.instance.currentUser;

class _InfoScreenState extends State<InfoScreen> {
  final ref = FirebaseDatabase.instance.ref("iot_m/${user!.uid}/iot");
  final homeController = Get.put(HomeContoller(1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      body: WillPopScope(
        onWillPop: () async {
          homeController.onInit();
          return true;
        },
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/playstore.png'),
              scale: 3,
              opacity: 0.1,
            ),
          ),
          child: Column(
            children: [
              firebaseListWiget(),
              infoTextWidget(),
            ],
          ),
        ),
      ),
      bottomSheet: const BottomText(),
    );
  }

  AppBar appBarWidget() {
    return AppBar(
      title: Text('Database Information'.tr),
      backgroundColor: const Color.fromARGB(255, 0, 53, 96),
      leading: IconButton(
        onPressed: () {
          Get.back();
          homeController.onInit();
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
        ),
      ),
    );
  }

  Container firebaseListWiget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      width: Get.width,
      height: Get.height / 2.2,
      child: FirebaseAnimatedList(
        query: ref,
        itemBuilder: (context, snapshot, animation, index) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(143, 255, 193, 7),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'IoT Switch $index: ',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(
                  '${snapshot.child('iot_m/').value}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
                ),
                Icon(
                  snapshot.child('iot_m/').value == 'true'
                      ? Icons.lock_open
                      : Icons.lock,
                ),
              ],
            ),
          );
        },
        scrollDirection: Axis.vertical,
      ),
    );
  }

  Padding infoTextWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Text(
        'If you want to know if your keys are really open, you can follow the real-time database from the list above.'
            .tr,
        textWidthBasis: TextWidthBasis.longestLine,
        textAlign: TextAlign.center,
        style: GoogleFonts.raleway(
          fontSize: 18.0,
          height: 1.5,
          wordSpacing: 3.0,
        ),
      ),
    );
  }
}
