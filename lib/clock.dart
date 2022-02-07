import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:mytoodoo/Constents.dart';

class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(15.0),
          width: 190,
          height: 190,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0xffdfe7ee),
                spreadRadius: 2,
                offset: Offset(4, 4), // changes position of shadow
              ),
            ],
          ),
        ),
        AnalogClock(
          height: 240,
          width: 240,
          showDigitalClock: false,
          showNumbers: true,
          secondHandColor: mainColor,
          showTicks: false,
        ),
      ],
    );
  }
}
