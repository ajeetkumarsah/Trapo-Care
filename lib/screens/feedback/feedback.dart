import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/screens/widgets/custom_appbar.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  List<bool> isTypeSelected = [false, false, false, false, false];
  String userContactnumber, userIssue, username;

  final _formKey = GlobalKey<FormState>();

  getUserName(n) {
    this.username = n;
  }

  getContact(h) {
    this.userContactnumber = h;
  }

  getUserIssue(c) {
    this.userIssue = c;
  }

  int _feedbackType = 0;
  String postVal;
  void _handleFeedbackType(int value) {
    setState(() {
      _feedbackType = value;
      switch (_feedbackType) {
        case 1:
          postVal = 'User Interface';
          break;
        case 2:
          postVal = 'Updated Post';
          break;
        case 3:
          postVal = 'Wrong Information';
          break;
        case 4:
          postVal = 'Other issues';
          break;
        case 5:
          postVal = 'Suggestions';
          break;
      }
    });
  }

  createData() {
    DocumentReference ds =
        Firestore.instance.collection('usersFeedback').document();
    Map<String, dynamic> post = {
      "username": username,
      "userContactNumber": userContactnumber,
      "feedbacktype": postVal,
      "userIssue": userIssue,
    };

    ds.setData(post).whenComplete(() {
      print('Post Created');

      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              title: Text(
                'Trapo Care',
                textAlign: TextAlign.center,
              ),
              content: Text(
                'Thank you for your feedback!',
                textAlign: TextAlign.center,
              ),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        onPressed: () => Navigator.pop(context),
        title: 'Feedback',
        child: kBackBtn,
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Please select the type of your feedback",
                      style: TextStyle(
                        color: blueColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 25.0),
                    GestureDetector(
                      child: buildCheckItem(
                          title: "User Interface",
                          isSelected: isTypeSelected[0]),
                      onTap: () {
                        setState(() {
                          _handleFeedbackType(1);
                          isTypeSelected[0] = !isTypeSelected[0];
                          isTypeSelected[3] = false;
                          isTypeSelected[1] = false;
                          isTypeSelected[2] = false;
                          isTypeSelected[4] = false;
                        });
                      },
                    ),
                    GestureDetector(
                      child: buildCheckItem(
                          title: "Updated Post", isSelected: isTypeSelected[1]),
                      onTap: () {
                        setState(() {
                          _handleFeedbackType(2);
                          isTypeSelected[1] = !isTypeSelected[1];
                          isTypeSelected[0] = false;
                          isTypeSelected[3] = false;
                          isTypeSelected[2] = false;
                          isTypeSelected[4] = false;
                        });
                      },
                    ),
                    GestureDetector(
                      child: buildCheckItem(
                          title: "Wrong Information",
                          isSelected: isTypeSelected[2]),
                      onTap: () {
                        setState(() {
                          _handleFeedbackType(3);
                          isTypeSelected[2] = !isTypeSelected[2];
                          isTypeSelected[0] = false;
                          isTypeSelected[1] = false;
                          isTypeSelected[3] = false;
                          isTypeSelected[4] = false;
                        });
                      },
                    ),
                    GestureDetector(
                      child: buildCheckItem(
                          title: "Other issues", isSelected: isTypeSelected[3]),
                      onTap: () {
                        setState(() {
                          _handleFeedbackType(4);
                          isTypeSelected[3] = !isTypeSelected[3];
                          isTypeSelected[0] = false;
                          isTypeSelected[1] = false;
                          isTypeSelected[2] = false;
                          isTypeSelected[4] = false;
                        });
                      },
                    ),
                    GestureDetector(
                      child: buildCheckItem(
                          title: "Suggestions", isSelected: isTypeSelected[4]),
                      onTap: () {
                        setState(() {
                          _handleFeedbackType(5);
                          isTypeSelected[4] = !isTypeSelected[4];
                          isTypeSelected[0] = false;
                          isTypeSelected[1] = false;
                          isTypeSelected[2] = false;
                          isTypeSelected[3] = false;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            buildFeedbackForm(),
                            SizedBox(height: 20.0),
                            buildUsernameField(),
                            SizedBox(
                              height: 20,
                            ),
                            buildNumberField(),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ignore: deprecated_member_use
                        FlatButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Processing Data')));
                              createData();
                            }
                          },
                          child: Text(
                            "SUBMIT",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          color: blueColor,
                          padding: EdgeInsets.all(16.0),
                        ),
                      ],
                    )
                  ],
                )),
          )),
    );
  }

  buildUsernameField() {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      keyboardType: TextInputType.name,
      onChanged: (String s) {
        getUserName(s);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Name Can\'t be <3';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0.0),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 1.0,
                    color: blueColor,
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: blueColor,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
        ),
        hintStyle: TextStyle(
          fontSize: 14.0,
          color: Color(0xFFC5C5C5),
        ),
        hintText: "Your name",
        border: OutlineInputBorder(),
      ),
    );
  }

  buildNumberField() {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      keyboardType: TextInputType.number,
      onChanged: (String s) {
        getContact(s);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Number must be 10 digits.';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0.0),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 1.0,
                    color: blueColor,
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "+91",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: blueColor,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
        ),
        hintStyle: TextStyle(
          fontSize: 14.0,
          color: Color(0xFFC5C5C5),
        ),
        hintText: "Phone Number",
        border: OutlineInputBorder(),
      ),
    );
  }

  buildFeedbackForm() {
    return Container(
      height: 200,
      child: Stack(
        children: [
          TextFormField(
            maxLines: 10,
            onChanged: (String s) {
              getUserIssue(s);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Please briefly describe the issue",
              hintStyle: TextStyle(
                fontSize: 13.0,
                color: Color(0xFFC5C5C5),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFE5E5E5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCheckItem({String title, bool isSelected}) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.check_circle : Icons.circle,
            color: isSelected ? blueColor : Colors.grey,
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? blueColor : Colors.grey),
          ),
        ],
      ),
    );
  }
}
