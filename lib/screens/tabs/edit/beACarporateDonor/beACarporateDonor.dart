import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/screens/widgets/custom_appbar.dart';
import 'package:trapo_care/screens/widgets/myTextFormField.dart';

class BeACorporateDonor extends StatefulWidget {
  @override
  _BeACorporateDonorState createState() => _BeACorporateDonorState();
}

class _BeACorporateDonorState extends State<BeACorporateDonor> {
  String username,
      phoneNumber,
      companyEmail,
      companyName,
      referredBy,
      otherDetails,
      email;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _btnEnabled = false;
  String countryValue = '';
  getUserName(s) {
    this.username = s;
  }

  getEmail(e) {
    this.email = e;
  }

  getPhoneNumber(p) {
    this.phoneNumber = p;
  }

  getCompanyName(o) {
    this.companyName = o;
  }

  getCompanyEmail(e) {
    this.companyEmail = e;
  }

  getReferredBy(r) {
    this.referredBy = r;
  }

  getOtherDetails(o) {
    this.otherDetails = o;
  }

  createData() {
    DocumentReference ds =
        Firestore.instance.collection('Be a Carporate Donor').document();
    Map<String, dynamic> post = {
      "State": selectedState,
      "City": selectedCity,
      "Company Name": companyName,
      'Company Email': email,
      'Contact Person': username,
      'Contact Number': phoneNumber,
      'Referred By': referredBy,
      'Other Details': otherDetails,
      'createdAt': FieldValue.serverTimestamp(),
      'Status': 'Unverified',
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
                'Thank you for becoming a Corporate Donor! ;)',
                textAlign: TextAlign.center,
              ),
            );
          });
    });
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(40),
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                new CircularProgressIndicator(),
                new Text(
                  "Please wait...",
                  style: TextStyle(
                    color: blueColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 4), () {
      Navigator.pop(context); //pop dialog
    });
  }

  String selectedState;
  String selectedCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        onPressed: () => Navigator.pop(context),
        title: 'Be a Corporate Donor',
        child: kBackBtn,
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
                // height: MediaQuery.of(context).size.height,
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  CSCPicker(
                                    showStates: true,
                                    showCities: true,
                                    defaultCountry: DefaultCountry.India,
                                    flagState: CountryFlag.DISABLE,
                                    onCountryChanged: (value) {
                                      setState(() {
                                        countryValue = value;
                                      });
                                    },
                                    onStateChanged: (value) {
                                      setState(() {
                                        selectedState = value;
                                      });
                                    },
                                    onCityChanged: (value) {
                                      setState(() {
                                        selectedCity = value;
                                      });
                                    },
                                    selectedItemStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    dropdownHeadingStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                    dropdownItemStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    dropdownDialogRadius: 10.0,
                                    searchBarRadius: 10.0,
                                  ),
                                ],
                              )),
                        ),
                        MyTextFormField(
                          labelText: 'Company Name',
                          requiredField: true,
                          onChanged: (o) {
                            getCompanyName(o);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field can\'t be empty!';
                            }
                            return null;
                          },
                        ),
                        MyTextFormField(
                          labelText: 'Company Email',
                          requiredField: true,
                          onChanged: (o) {
                            getEmail(o);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field can\'t be empty!';
                            }
                            return null;
                          },
                        ),
                        MyTextFormField(
                          labelText: 'Contact Person Name',
                          requiredField: true,
                          onChanged: (o) {
                            getUserName(o);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field can\'t be empty!';
                            }
                            return null;
                          },
                        ),
                        MyTextFormField(
                          limit: true,
                          isNumber: true,
                          labelText: 'Contact Person Number',
                          onChanged: (String s) {
                            getPhoneNumber(s);
                            setState(() =>
                                _btnEnabled = _formKey.currentState.validate());
                          },
                          requiredField: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field can\'t be empty!';
                            }
                            return null;
                          },
                        ),
                        MyTextFormField(
                          labelText: 'Who referred you?',
                          onChanged: (o) {
                            getReferredBy(o);
                          },
                        ),
                        MyTextFormField(
                          labelText: 'Other Details (Optional)',
                          onChanged: (o) {
                            getOtherDetails(o);
                          },
                        ),
                      ],
                    )),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _btnEnabled
                        // ignore: deprecated_member_use
                        ? FlatButton(
                            onPressed: () {
                              if (_formKey.currentState.validate() &&
                                  selectedCity != null &&
                                  selectedState != null &&
                                  countryValue == 'India') {
                                _onLoading();
                                createData();
                              } else if (countryValue != 'India') {
                                // ignore: deprecated_member_use
                                _scaffoldKey.currentState.showSnackBar(
                                    new SnackBar(
                                        content: new Text(
                                            "Selected Country is not 'India'")));
                              } else {
                                // ignore: deprecated_member_use
                                _scaffoldKey.currentState.showSnackBar(
                                    new SnackBar(
                                        content: new Text(
                                            'Provide the required fields!')));
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
                          )
                        // ignore: deprecated_member_use
                        : FlatButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                // ignore: deprecated_member_use
                                _scaffoldKey.currentState.showSnackBar(
                                    new SnackBar(
                                        content: new Text(
                                            'Provide the required fields!')));
                              }
                            },
                            child: Text(
                              "SUBMIT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            color: Colors.grey,
                            padding: EdgeInsets.all(16.0),
                          ),
                  ],
                )
              ],
            )),
          )),
    );
  }
}
