import 'package:flutter/material.dart';
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
              Image.asset(
                empty,
                height: _height * 0.2,
                width: _width * 0.3,
                fit: BoxFit.fitWidth,
              ),
              Shimmer.fromColors(
                  baseColor: blueColor,
                  highlightColor: Colors.grey[100],
                  enabled: true,
                  child: Text('Coming back soon..',
                      style: TextStyle(
                        color: blueColor,
                        fontWeight: FontWeight.w300,
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
