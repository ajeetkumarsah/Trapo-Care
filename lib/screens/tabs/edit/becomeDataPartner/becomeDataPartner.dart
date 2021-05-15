import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/screens/widgets/custom_appbar.dart';
import 'package:trapo_care/screens/widgets/myTextFormField.dart';

class BecomeDataPartner extends StatefulWidget {
  @override
  _BecomeDataPartnerState createState() => _BecomeDataPartnerState();
}

class _BecomeDataPartnerState extends State<BecomeDataPartner> {
  String username,
      phoneNumber,
      hoursPerDay,
      referredBy,
      description,
      dataPlatform,
      noOfLeads,
      noOfVolunteers,
      websiteURL,
      organizationName,
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

  getOtherDetails(o) {
    this.otherDetails = o;
  }

  getPhoneNumber(p) {
    this.phoneNumber = p;
  }

  getWebsiteURL(h) {
    this.websiteURL = h;
  }

  getReferredBy(r) {
    this.referredBy = r;
  }

  getOrganizationName(o) {
    this.organizationName = o;
  }

  getDescription(d) {
    this.description = d;
  }

  getDataPlatform(d) {
    this.dataPlatform = d;
  }

  getNoOfLeads(l) {
    this.noOfLeads = l;
  }

  getNoOfVolunteers(v) {
    this.noOfVolunteers = v;
  }

  createData() {
    DocumentReference ds =
        Firestore.instance.collection('Become Data Partner').document();
    Map<String, dynamic> post = {
      "State": selectedState,
      "City": selectedCity,
      "Organization Name": organizationName,
      "Description": description,
      'Website URL': websiteURL,
      'Data Platform': dataPlatform,
      'No of Leads': noOfLeads,
      'No of Volunteers': noOfVolunteers,
      'Contact Person': username,
      'Email': email,
      'Contact Number': phoneNumber,
      'Referred By': referredBy,
      'Other Details': otherDetails,
      'Last Updated': FieldValue.serverTimestamp(),
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
                'Thank you for becoming our Data Partner ;)',
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

  List<String> city = [];
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
        title: 'Become Data Partner',
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
                SizedBox(
                  height: 10.0,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        MyTextFormField(
                          labelText: 'Organization Name',
                          onChanged: (o) {
                            getOrganizationName(o);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field can\'t be empty!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        buildDescriptionField(),
                        SizedBox(
                          height: 10.0,
                        ),
                        MyTextFormField(
                          labelText: 'Website URL',
                          onChanged: (o) {
                            getWebsiteURL(o);
                          },
                        ),
                        MyTextFormField(
                          labelText: 'Data Platform',
                          requiredField: true,
                          onChanged: (o) {
                            getDataPlatform(o);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field can\'t be empty!';
                            }
                            return null;
                          },
                        ),
                        MyTextFormField(
                          isNumber: true,
                          labelText: 'No of Leads',
                          onChanged: (o) {
                            getNoOfLeads(o);
                          },
                        ),
                        MyTextFormField(
                          isNumber: true,
                          labelText: 'No of Volunteers',
                          onChanged: (o) {
                            getNoOfVolunteers(o);
                          },
                        ),
                        MyTextFormField(
                          labelText: 'Your Full Name',
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
                          labelText: 'Your Phone Number',
                          onChanged: (String s) {
                            getPhoneNumber(s);
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
                          labelText: 'Your Email Address',
                          requiredField: true,
                          onChanged: (o) {
                            getEmail(o);
                            setState(() =>
                                _btnEnabled = _formKey.currentState.validate());
                          },
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ignore: deprecated_member_use
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
                            color: Colors.grey[500],
                            padding: EdgeInsets.all(16.0),
                          ),
                  ],
                )
              ],
            )),
          )),
    );
  }

  buildDescriptionField() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      height: 100,
      child: Stack(
        children: [
          TextFormField(
            maxLines: 10,
            onChanged: (String s) {
              getDescription(s);
            },
            decoration: InputDecoration(
              labelText: "Description",
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
}

class BuidNameField extends StatelessWidget {
  final String title;
  final String hint;
  @required
  final Function onChanged;

  const BuidNameField({Key key, this.title, this.hint, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      keyboardType: TextInputType.name,
      onChanged: onChanged,
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
                    title,
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
        hintText: hint,
        border: OutlineInputBorder(),
      ),
    );
  }
}
