import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/helper/imageHelper.dart';
import 'package:trapo_care/screens/tabs/edit/argument/haveAnyLeadsArgument.dart';
import 'package:trapo_care/screens/widgets/circular_floating_buttons.dart';

import 'model/Post.dart';
import 'model/firestoreservices.dart';

String username;
String phone;

// String _returnDate(){
//     DateTime date = new DateTime.fromMillisecondsSinceEpoch(paymentsModel.createdAt);
//     return timeago.format(date, locale: 'fr');
//   }
class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> with TickerProviderStateMixin {
  List<Post> items;
  FirestoreService fireServ = new FirestoreService();
  StreamSubscription<QuerySnapshot> requestedPost;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
////
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

    requestedPost?.cancel();
    requestedPost = fireServ.getTaskList().listen((QuerySnapshot snapshot) {
      final List<Post> tasks = snapshot.documents
          .map((documentSnapshot) => Post.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = tasks;
      });
    });
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var uusername = sharedPreferences.getString('Username');
    var uphone = sharedPreferences.getString('Phone');
    setState(() {
      username = uusername;
      phone = uphone;
    });
    print(username);
    print(phone);
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uusername = prefs.getString('Username');
    var uphone = prefs.getString('Phone');
    bool _loggedIn = (prefs.getString('Username') != null &&
        prefs.getString('Phone') != null);

    if (_loggedIn) {
      Navigator.of(context).pushNamed('/haveAnyLeads',
          arguments: HaveAnyLeadsArgument(uusername, uphone));
    } else {
      showAlertDialog(context);
    }
  }

////////////////Alert dialog
  showAlertDialog(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uusername = prefs.getString('Username');
    var uphone = prefs.getString('Phone');
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Column(children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Align(
            alignment: Alignment.topRight,
            child: CircleAvatar(
              radius: 14.0,
              backgroundColor: Colors.white,
              child: Icon(Icons.close, color: Colors.red),
            ),
          ),
        ),
        Text("LOGIN", style: TextStyle(color: blueColor)),
      ]),
      //Text("AlertDialog"),
      content: Container(
        height: 140,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                icon: Icon(FontAwesomeIcons.userAlt),
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(FontAwesomeIcons.mobileAlt),
                labelText: 'Contact number',
              ),
            ),
          ],
        ),
      ),
      actions: [
        // ignore: deprecated_member_use
        TextButton(
          onPressed: () async {
            if (_usernameController.text != null &&
                _usernameController.text.isNotEmpty &&
                _phoneController.text != null &&
                _phoneController.text.isNotEmpty) {
              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.setString('Username', _usernameController.text);
              sharedPreferences.setString('Phone', _phoneController.text);
              Navigator.pop(context);
              Navigator.pushNamed(context, '/haveAnyLeads',
                  arguments: HaveAnyLeadsArgument(uusername, uphone));
            } else {}
          },
          child: Text(
            "Login ",
            style: TextStyle(color: blueColor, fontSize: 16),
          ),
        ),
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            // height: _height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: _height * 0.17,
                    width: _width * 0.98,
                    child: Container(
                      child: Image.asset(
                        superhero,
                        //fit: BoxFit.cover,
                      ),
                    )),
                SizedBox(height: 10),
                Text(
                  "Be a Superhero! Join \nForces",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Text(
                  "We’re a team of strangers. A common mission -- to help India during the Covid crisis, brought us all together to create this platform.We need your support. If you’ve any verified information, we sincerely request you to add it. Don’t worry! We’ll verify it before publishing. If you want to help us in verifying and updating all the information, please become a volunteer. We need you. If you’ve developed a similar platform, let’s join hands to create a common database, enabling consistent information across the platforms.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () => checkFirstSeen(),
                    child: Container(
                        padding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
                        height: 70,
                        width: _width * 0.9,
                        decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all()),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Have Any leads?',
                              style: TextStyle(color: whiteColor, fontSize: 18),
                            ),
                            Text(
                              'Click Here To Submit Information.',
                              style: TextStyle(
                                  color: whiteColor.withOpacity(0.5),
                                  fontSize: 15),
                            ),
                          ],
                        ))),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed('/volunteerWithUs'),
                    child: Container(
                        padding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
                        height: 70,
                        width: _width * 0.9,
                        decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all()),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Volunteer With Us',
                              style: TextStyle(color: whiteColor, fontSize: 18),
                            ),
                            Text(
                              'Click Here To Join The Mission.',
                              style: TextStyle(
                                  color: whiteColor.withOpacity(0.5),
                                  fontSize: 15),
                            ),
                          ],
                        ))),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () =>
                        {Navigator.of(context).pushNamed('/becomeDataPartner')},
                    child: Container(
                        padding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
                        height: 70,
                        width: _width * 0.9,
                        decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all()),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Become Data Partner',
                              style: TextStyle(color: whiteColor, fontSize: 18),
                            ),
                            Text(
                              'Click Here To Join as a Partner.',
                              style: TextStyle(
                                  color: whiteColor.withOpacity(0.5),
                                  fontSize: 15),
                            ),
                          ],
                        ))),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () =>
                        {Navigator.of(context).pushNamed('/beACarporateDonor')},
                    child: Container(
                        padding: EdgeInsets.only(left: 30, top: 5, bottom: 5),
                        height: 70,
                        width: _width * 0.9,
                        decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all()),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Be a Carporate Donor',
                              style: TextStyle(color: whiteColor, fontSize: 18),
                            ),
                            Text(
                              'Click Here To Join as a Donor.',
                              style: TextStyle(
                                  color: whiteColor.withOpacity(0.5),
                                  fontSize: 15),
                            ),
                          ],
                        ))),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
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
