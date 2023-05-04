import 'package:flutter/material.dart';

class BottomText extends StatelessWidget {
  const BottomText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.copyright,
            size: 13.0,
          ),
          SizedBox(width: 5.0),
          Text(
            'Developed by ',
            style: TextStyle(fontSize: 12.0),
          ),
          Text(
            'Hüseyin ADIGÜZEL',
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
