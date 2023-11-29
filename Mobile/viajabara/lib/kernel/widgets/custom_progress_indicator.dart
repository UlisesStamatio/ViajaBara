import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';

class CustomCircularProgressIndicator extends StatefulWidget {
  @override
  _CustomCircularProgressIndicatorState createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator> {
  late double _position;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _position = 0.0;
    _timer = Timer.periodic(Duration(milliseconds: 16), _updatePosition);
  }

  void _updatePosition(Timer timer) {
    setState(() {
      _position += 1.0;
      if (_position > MediaQuery.of(context).size.width) {
        _position = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
            child: SvgPicture.asset(
              StuffApp.bgGeneral,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            left: _position,
            top: MediaQuery.of(context).size.height / 2 - 100,
            child: SvgPicture.asset(
              StuffApp.logoViajabara,
              height: 50,
              width: 50,
            ),
          ),
          const Center(
            child: LinearProgressIndicator(
              color: ColorsApp.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
