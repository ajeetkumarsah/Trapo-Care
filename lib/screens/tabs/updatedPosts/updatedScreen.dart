import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/helper/imageHelper.dart';
import 'package:trapo_care/screens/tabs/updatedPosts/widget/search_screen.dart';
import 'package:trapo_care/screens/widgets/circular_floating_buttons.dart';
import 'package:trapo_care/screens/widgets/get_post.dart';

class UpdatedScreen extends StatefulWidget {
  @override
  _UpdatedScreenState createState() => _UpdatedScreenState();
}

class _UpdatedScreenState extends State<UpdatedScreen>
    with TickerProviderStateMixin {
  bool _isSearch = false;
  AnimationController animationController;
  Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation rotationAnimation;
  Animation rotationAnimation1;
  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 0.0, end: 135.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    rotationAnimation1 = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: _isSearch
            ? SearchScreen()
            : StreamBuilder(
                stream: Firestore.instance
                    .collection('Have any Leads')
                    .where('Status', isEqualTo: 'Verified')
                    .orderBy('Last Updated', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return GetPosts(
                    snapshot: snapshot,
                  );
                }),
        floatingActionButton: Transform(
          transform:
              Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value)),
          alignment: Alignment.center,
          child: CircularButton1(
            color: redColor,
            iconSize: _isSearch ? 35 : 50,
            width: 60,
            height: 60,
            iconColor: whiteColor,
            icon: _isSearch
                ? ImageIcon(AssetImage(
                    pluswhite,
                  ))
                : ImageIcon(
                    AssetImage(
                      search,
                    ),
                    size: 60,
                  ),
            onClick: () {
              if (animationController.isCompleted) {
                setState(() {
                  _isSearch = !_isSearch;
                });
                animationController.reverse();
              } else {
                setState(() {
                  _isSearch = !_isSearch;
                });
                animationController.forward();
              }
            },
          ),
        ));
  }
}
