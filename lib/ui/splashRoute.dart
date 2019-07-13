import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

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
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(0.0),
                height: 500,
                child: Image.network("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562148"
                    "947999&di=7abc660843cbd4af63dde37af6c0938a&imgtype=0&src=http%3A%2F%2Fb-ssl.duita"
                    "ng.com%2Fuploads%2Fitem%2F201803%2F14%2F20180314123303_n2hWG.jpeg"),
              ),
              Text(
                "Flamingo Diary",
                style: TextStyle(
                  fontSize: 19.0,
                  color: Colors.red[400]
                ),
              )
            ],
          ),
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

