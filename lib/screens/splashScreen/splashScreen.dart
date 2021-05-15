import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/helper/imageHelper.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _height, _width;
  final splashDelay = 2;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, checkFirstSeen);
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacementNamed("/home");
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacementNamed("/onboardingScreen");
    }
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: redColor,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.topRight,
                child: Image.asset(
                  plusIcon,
                  height: _height * 0.3,
                  width: _width * 0.6,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Material(
                        type: MaterialType.transparency,
                        elevation: 10.0,
                        child: Column(children: [
                          Image.asset(
                            ewhite,
                            height: _height * 0.1,
                            width: _width * 0.2,
                            fit: BoxFit.fitWidth,
                          ),
                          Image.asset(
                            trapocarewhite,
                            height: _height * 0.07,
                            width: _width * 0.7,
                            fit: BoxFit.fitWidth,
                          ),
                        ]),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          color: redColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Text(
                  "Made with ♥ in India",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                      color: whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0),
                ),
              ),
            ],
          ),
        ));
  }
}
