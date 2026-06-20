// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class CustomPowerSwitch extends StatefulWidget {
  const CustomPowerSwitch({
    super.key,
    this.width,
    this.height,
  });

  final double? width;

  final double? height;

  @override
  State<CustomPowerSwitch> createState() => _CustomPowerSwitchState();
}

class _CustomPowerSwitchState extends State<CustomPowerSwitch> {
  bool value = false;

  @override
  void initState() {
    super.initState();

    value = FFAppState().adhkarSound;
  }

  void toggle() {
    setState(() {
      value = !value;

      FFAppState().update(() {
        FFAppState().adhkarSound = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 50,
        height: 20,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: value ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // LEFT ICON (vibration)

            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              alignment: value ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.vibration,
                  size: 20,
                  color: Colors.white.withOpacity(value ? 1 : 0.3),
                ),
              ),
            ),

            // RIGHT ICON (circle)

            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.circle,
                  size: 12,
                  color: Colors.white.withOpacity(value ? 0.3 : 1),
                ),
              ),
            ),

            // THUMB

            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
////////////
///////////
