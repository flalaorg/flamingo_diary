import 'package:flutter/material.dart';
import 'dart:async';

class SplashRoute extends StatefulWidget {

  SplashRoute({
    Key key,
    this.homeRoute,
    this.countdownSeconds = 2,

  }): super(key: key);

  final Widget homeRoute;
  final int countdownSeconds;

  @override
  _SplashRouteState createState() => _SplashRouteState();
}

class _SplashRouteState extends State<SplashRoute> {
  Timer _countdownTimer;
  String _countdownStr;

  @override
  void initState() {
    super.initState();
    int time = widget.countdownSeconds;
    _countdownStr = "跳过 ${time.toString() }S";

    _countdownTimer = Timer.periodic(Duration(seconds: time), (timer) {
      setState(() {
        if (timer.tick < time)
          _countdownStr = "跳过${time - timer.tick}S";
        else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => widget.homeRoute));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white
      ),
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Text("wow"),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => widget.homeRoute));
          },
          child: Text(_countdownStr, style: TextStyle(
            fontSize: 12.0,
          ),),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }
}
