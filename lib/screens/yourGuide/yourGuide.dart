import 'package:flutter/material.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/screens/widgets/custom_appbar.dart';
import 'package:trapo_care/screens/widgets/emptyview.dart';

class YourGuide extends StatefulWidget {
  @override
  _YourGuideState createState() => _YourGuideState();
}

class _YourGuideState extends State<YourGuide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        onPressed: () => Navigator.pop(context),
        title: 'Your Guide',
        child: kBackBtn,
      ),
      body: EmptyView(),
    );
  }
}
