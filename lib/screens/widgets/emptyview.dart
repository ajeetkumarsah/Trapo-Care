import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/helper/imageHelper.dart';

// ignore: must_be_immutable
class EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: whiteColor,
        body: Center(
          child: Material(
            type: MaterialType.transparency,
            elevation: 10.0,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 250,
                width: 250,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: blueColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(900),
                ),
                child: Lottie.asset(
                  'assets/animation/corona.json',
                  repeat: true,
                  reverse: true,
                  animate: true,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Shimmer.fromColors(
                  baseColor: blueColor,
                  highlightColor: Colors.grey[100],
                  enabled: true,
                  child: Text('Coming back soon..',
                      style: TextStyle(
                        color: blueColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ))),
            ]),
          ),
        ));
  }

  Widget kBackBtn = Icon(
    Icons.arrow_back_ios,
    color: whiteColor,
  );
}
