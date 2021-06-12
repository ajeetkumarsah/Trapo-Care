import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/helper/imageHelper.dart';
import 'package:trapo_care/screens/widgets/cardView.dart';
import 'package:trapo_care/screens/widgets/circular_floating_buttons.dart';
import 'package:trapo_care/screens/widgets/sliderWidget.dart';

class ResourceScreen extends StatefulWidget {
  @override
  _ResourceScreenState createState() => _ResourceScreenState();
}

class _ResourceScreenState extends State<ResourceScreen>
    with TickerProviderStateMixin {
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

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _surveydone = (prefs.getBool('surveydone') ?? false);

    if (_surveydone) {
      Navigator.pushNamed(context, '/surveyLastScreen');
    } else {
      await prefs.setBool('surveydone', true);
      Navigator.of(context).pushNamed('/surveyScreenNew');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: whiteColor,
        body: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      padding: EdgeInsets.only(top: 4, bottom: 4),
                      alignment: Alignment.center,
                      height: 210,
                      child: SliderWidget(),
                    ),
                    ListTile(
                      title: AutoSizeText(
                        'COVID-19 Resources\n What do you need?',
                        style: TextStyle(
                            color: blueColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                        minFontSize: 12,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: GestureDetector(
                          onTap: () {
                            checkFirstSeen();
                          },
                          child: Container(
                              height: 35,
                              width: 120,
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                  color: blueColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  'GET VACCINE',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))),
                    ),
                    // Container(
                    //   padding: EdgeInsets.all(10),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       AutoSizeText(
                    //         'COVID-19 Resources\n What do you need?',
                    //         style: TextStyle(
                    //             color: blueColor,
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 17),
                    //         minFontSize: 12,
                    //         maxLines: 2,
                    //         overflow: TextOverflow.ellipsis,
                    //       ),
                    //       // Text('COVID-19 Resources\n What do you need?',
                    //       //     style: TextStyle(
                    //       //         color: blueColor,
                    //       //         fontWeight: FontWeight.bold,
                    //       //         fontSize: 17),
                    //       //     overflow: TextOverflow.ellipsis),
                    //       GestureDetector(
                    //           onTap: () {
                    //             checkFirstSeen();
                    //           },
                    //           child: Container(
                    //               height: 35,
                    //               width: 120,
                    //               decoration: BoxDecoration(
                    //                   color: blueColor,
                    //                   borderRadius: BorderRadius.circular(20)),
                    //               child: Center(
                    //                 child: Text(
                    //                   'GET VACCINE',
                    //                   style: TextStyle(color: Colors.white),
                    //                 ),
                    //               ))),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                delegate: SliverChildListDelegate(
                  [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/oxygen');
                        },
                        child: CardView(url: oxygen, title: 'Oxygen')),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/bedVentilator');
                      },
                      child: CardView(url: bed, title: 'Beds | ICU'),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/donate');
                        },
                        child: CardView(
                            url: bloodPlasma, title: 'Plasma | Blood ')),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/ambulance');
                        },
                        child: CardView(url: ambulance, title: 'Ambulance')),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/delivery');
                        },
                        child: CardView1(
                            url: medicine,
                            title: 'Medicine delivery for Patients')),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/mealScreen');
                        },
                        child: CardView1(
                            url: food, title: 'Food delivery for Patients')),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                delegate: SliverChildListDelegate(
                  [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/covid');
                        },
                        child: CardView(url: covid, title: 'Covid Testing')),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/homecare');
                        },
                        child: CardView(
                            url: homeCare, title: 'Home Care \n  Facilities')),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/pvthospital');
                        },
                        child: CardView(url: hospital, title: 'Hospitals')),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/doctorsScreen');
                        },
                        child: CardView(url: doctor, title: 'Doctors')),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/helpline');
                        },
                        child: CardView(
                            url: otherResource,
                            title: 'Helpline & Other Resources')),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/userGuideScreen');
                        },
                        child: CardView(url: guide, title: 'Your Guide')),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      height: 210,
                      color: Colors.white,
                      child: Text(
                        'This list of resources is crowdsourced. The purpose of this is to ensure that all the information scattered across various social media platforms is organised methodically in one place, accessible to all, and easy to find at times of need. Those who submit leads attached here will be credited by name, the rest of the information has primarily been gathered from Facebook, Instagram and Twitter.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      height: 60,
                      color: Colors.white,
                      child: Text(
                        '©2021 Trapo Tech \n• Privacy Policy • Terms of Service',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            IgnorePointer(
              child: Container(
                color: Colors.transparent,
                height: 150.0,
                width: 150.0,
              ),
            ),
            Transform.translate(
              offset: Offset.fromDirection(getRadiansFromDegree(250),
                  degOneTranslationAnimation.value * 100),
              child: Transform(
                transform: Matrix4.rotationZ(
                    getRadiansFromDegree(rotationAnimation1.value))
                  ..scale(degOneTranslationAnimation.value),
                alignment: Alignment.center,
                child: CircularButton(
                  color: whiteColor,
                  iconColor: redColor,
                  width: 50,
                  height: 50,
                  msg: 'Emergency!',
                  icon: ImageIcon(AssetImage(ewhite)),
                  onClick: () {
                    if (animationController.isCompleted) {
                      animationController.reverse();
                    } else {
                      animationController.forward();
                    }
                    Navigator.of(context).pushNamed('/emergency');
                  },
                ),
              ),
            ),
            Transform.translate(
              offset: Offset.fromDirection(getRadiansFromDegree(200),
                  degTwoTranslationAnimation.value * 100),
              child: Transform(
                transform: Matrix4.rotationZ(
                    getRadiansFromDegree(rotationAnimation1.value))
                  ..scale(degTwoTranslationAnimation.value),
                alignment: Alignment.center,
                child: CircularButton(
                  msg: 'Feedback',
                  color: whiteColor,
                  iconColor: redColor,
                  width: 50,
                  height: 50,
                  icon: ImageIcon(AssetImage(feedbackwhite)),
                  onClick: () {
                    if (animationController.isCompleted) {
                      animationController.reverse();
                    } else {
                      animationController.forward();
                    }
                    Navigator.of(context).pushNamed('/feedback');
                  },
                ),
              ),
            ),
            Transform(
              transform: Matrix4.rotationZ(
                  getRadiansFromDegree(rotationAnimation.value)),
              alignment: Alignment.center,
              child: CircularButton1(
                color: redColor,
                width: 60,
                height: 60,
                iconColor: whiteColor,
                icon: ImageIcon(AssetImage(
                  pluswhite,
                )),
                onClick: () {
                  if (animationController.isCompleted) {
                    animationController.reverse();
                  } else {
                    animationController.forward();
                  }
                },
              ),
            )
          ],
        ));
  }
}
