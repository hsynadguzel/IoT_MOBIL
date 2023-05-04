import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextSwitch extends StatefulWidget {
  TextSwitch({super.key, required this.textNumber, required this.switchValue});
  final String textNumber;
  bool switchValue;

  @override
  State<TextSwitch> createState() => _TextSwitchState();
}

class _TextSwitchState extends State<TextSwitch> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 204.0,
      width: MediaQuery.of(context).size.width / 2.4,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 224, 224, 224),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 22.0),
          textWidget(),
          const SizedBox(height: 20.0),
          iconWidget(),
          const SizedBox(height: 16.0),
          CupertinoSwitch(
            value: widget.switchValue,
            activeColor: const Color.fromARGB(190, 0, 101, 168),
            onChanged: (bool value) async {
              setState(() {
                widget.switchValue = value;
              });
              final ref =
                  FirebaseDatabase.instance.ref("iot_m/${user!.uid}/iot");
              await ref.update(
                {'IoT Switch ${widget.textNumber}': value.toString()},
              );
            },
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  Icon iconWidget() {
    return Icon(
      widget.switchValue == true ? Icons.power_outlined : Icons.power_off_sharp,
      size: 65.0,
    );
  }

  Text textWidget() {
    return Text(
      'IoT Switch ${widget.textNumber}',
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    );
  }
}
