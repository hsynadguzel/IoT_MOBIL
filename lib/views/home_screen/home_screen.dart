import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_mobil/const/bottom_text.dart';
import 'package:iot_mobil/const/text_switch.dart';
import 'package:iot_mobil/controllers/home_controller.dart';
import 'package:iot_mobil/views/info_screen/info_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeContoller(0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              /* Text(
                'User ${homeController.uref.parent!.ref}',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),*/
              // row 1 -> 2 switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => TextSwitch(
                        textNumber: '1',
                        switchValue: homeController.switch_1.value),
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => TextSwitch(
                        textNumber: '2',
                        switchValue: homeController.switch_2.value),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // row 2 -> 2 switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => TextSwitch(
                        textNumber: '3',
                        switchValue: homeController.switch_3.value),
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => TextSwitch(
                        textNumber: '4',
                        switchValue: homeController.switch_4.value),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // 1 switch
              Obx(
                () => TextSwitch(
                    textNumber: '5',
                    switchValue: homeController.switch_5.value),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      bottomSheet: const BottomText(),
    );
  }

  AppBar appBarWidget(BuildContext context) {
    return AppBar(
      title: Text('IoT Switch Controls Unit'.tr),
      actions: [
        IconButton(
          onPressed: () {
            Get.to(() => const InfoScreen());
          },
          icon: const Icon(
            Icons.data_thresholding_outlined,
            size: 26.0,
          ),
        ),
      ],
      backgroundColor: const Color.fromARGB(255, 0, 53, 96),
    );
  }
}
