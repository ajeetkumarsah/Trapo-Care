import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/screens/tabs/edit/helper/helper.dart';
import 'package:trapo_care/screens/tabs/posts/services/service.dart';
import 'package:trapo_care/screens/widgets/custom_appbar.dart';
import 'package:trapo_care/screens/widgets/myTextFormField.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  String authorName, otherDetails;

  File selectedImage;

  bool _btnEnabled = false;
  CrudMethods crudMethods = new CrudMethods();
  final _formKey = GlobalKey<FormState>();
  List<String> resource = [];
  String selectedResourceType;
  String selectedResourceSubtype;
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = image;
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
                new CircularProgressIndicator(
                  color: blueColor,
                ),
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

    //Navigator.pop(context);
    new Future.delayed(new Duration(seconds: 4), () {
      Navigator.pop(context); //pop dialog
    });
  }

  uploadBlog() async {
    if (selectedImage != null) {
      setState(() {
        //_isLoading = true;
        _onLoading();
      });

      /// uploading image to firebase storage
      StorageReference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("UsersPost")
          .child("${randomAlphaNumeric(9)}.jpg");

      final StorageUploadTask task = firebaseStorageRef.putFile(selectedImage);

      var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
      print("this is url $downloadUrl");

      Map<String, dynamic> postMap = {
        "imgUrl": downloadUrl,
        "authorName": authorName,
        "Resource Type": selectedResourceType,
        "Resource Subtype": selectedResourceSubtype,
        'Other Details': otherDetails,
        'Status': 'Unverified',
        'createdAt': FieldValue.serverTimestamp(),
      };
      crudMethods.addData(postMap).then((result) {
        Navigator.pop(context);
      });
    } else {}
  }

  getResourceType(r) {
    this.selectedResourceType = r;
  }

  getSubResource(s) {
    this.selectedResourceSubtype = s;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        onPressed: () => Navigator.pop(context),
        title: 'Create Your Post',
        fontSize: 20,
        child: kBackBtn,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  getImage();
                },
                child: selectedImage != null
                    ? Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        height: 170,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.file(
                            selectedImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        height: 170,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(6)),
                        width: MediaQuery.of(context).size.width,
                        child: Icon(
                          Icons.add_a_photo_outlined,
                          size: 40,
                          color: redColor,
                        ),
                      )),
            SizedBox(
              height: 8,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    MyTextFormField(
                      labelText: 'Your Name',
                      onChanged: (val) {
                        authorName = val;
                        setState(() =>
                            _btnEnabled = _formKey.currentState.validate());
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Contact Number is empty';
                        }
                        return null;
                      },
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            border: Border.all(
                              color: Colors.grey[300],
                              width: 1.5,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                          child: DropdownButton<String>(
                            hint: Text('Resource Type*'),
                            value: selectedResourceType,
                            isExpanded: true,
                            items: resources.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (r) {
                              if (r == 'Oxygen') {
                                resource = oxygenResource;
                              } else if (r == 'Bed | ICU') {
                                resource = bedicuResource;
                              } else if (r == 'Blood | Plasma') {
                                resource = bloodplasmaResource;
                              } else if (r == 'Ambulance') {
                                resource = ambulanceResource;
                              } else if (r == 'Medicine') {
                                resource = medicineResource;
                              } else if (r == 'Food') {
                                resource = foodResource;
                              } else if (r == 'Covid Testing') {
                                resource = covidTestingResource;
                              } else if (r == 'Home Care Facilities') {
                                resource = homeCareFacilitiesResource;
                              } else if (r == 'Doctor') {
                                resource = doctorResource;
                              } else if (r == 'Hospital') {
                                resource = hospitalResource;
                              } else if (r == 'Helpline and Other Resources') {
                                resource = helplineAndOtherResource;
                              } else {
                                resource = [];
                              }
                              setState(() {
                                selectedResourceSubtype = null;
                                selectedResourceType = r;
                                getResourceType(r);
                              });
                            },
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              border: Border.all(
                                color: Colors.grey[300],
                                width: 1.5,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            child: DropdownButton<String>(
                              hint: Text('Resource Subtype'),
                              value: selectedResourceSubtype,
                              isExpanded: true,
                              items: resource.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (resource) {
                                setState(() {
                                  selectedResourceSubtype = resource;
                                  getSubResource(resource);
                                });
                              },
                            ))),
                    MyTextFormField(
                      labelText: 'Other Details',
                      onChanged: (val) {
                        otherDetails = val;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _btnEnabled
                      // ignore: deprecated_member_use
                      ? RaisedButton(
                          color: blueColor,
                          onPressed: () {
                            if (_formKey.currentState.validate() &&
                                selectedImage != null) {
                              uploadBlog();
                            }
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ))
                      // ignore: deprecated_member_use
                      : RaisedButton(
                          color: Colors.grey,
                          onPressed: () {
                            _onLoading();
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FullScreenImageArgument {
  final String url;

  FullScreenImageArgument(this.url);
}
