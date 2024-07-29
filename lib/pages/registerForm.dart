import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:praq_try/model/event.dart';
import 'package:praq_try/model/register.dart';
import 'package:praq_try/pages/eventDetailsPage.dart';
import 'package:praq_try/pages/registerDetailsPage.dart';
import 'package:praq_try/widgets/buildBottomSheet.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterTabPage extends StatelessWidget {
  const RegisterTabPage({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (context) => RegisterFormPage(event: event,)),
    
    );
  }
}

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({
    super.key,
    required this.event,
  });
  final Event event;

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  final nameController = TextEditingController();
  final icnoController = TextEditingController();
  final emailController = TextEditingController();
  final schoolController = TextEditingController();
  final addressController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  File? image;

  void submitForm() async {
    if (image == null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Warning'),
                content: Text('Please upload your image'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'))
                ],
              ));
    }
    if (formkey.currentState!.validate()) {
      Register tempRegister = Register(
          name: nameController.text,
          icno: icnoController.text,
          email: emailController.text,
          school: schoolController.text,
          address: addressController.text);

      var res = await Register.registerEvent(tempRegister, image!);

      if (res != null) {
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Success'),
                  content: Text('Your register is already submitted'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  EventDetailsPage(event: widget.event)));
                        },
                        child: Text('OK'))
                  ],
                ));
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EventDetailsPage(event: widget.event)));
      }
    } else {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Warning'),
                content: Text('Something went wrong'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'))
                ],
              ));
      return;
    }
  }

  Future<void> takePhoto(BuildContext context) async {
    ImageSource? source = await showModalBottomSheet(
        context: context, builder: (context) => buildBottomSheet(context));

    if (source == null) {
      return;
    }

    ImagePicker picker = ImagePicker();
    var file = await picker.pickImage(source: source);
    if (file == null) {
      return;
    }

    image = File(file.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            Center(
              child: Text(
                'REGISTRATION FORM',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
                key: formkey,
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          child: (image != null)
                              ? Image.file(image!)
                              : Container(
                                  child: Center(
                                    child: Text('Profile Picture'),
                                  ),
                                ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              takePhoto(context);
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                minimumSize: Size(double.infinity, 60)),
                            child: Text('upload')),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(label: Text('Name')),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: icnoController,
                          decoration: InputDecoration(label: Text('IC Number')),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your IC number';
                            } else if (value.length < 12) {
                              return 'Please enter your valid IC number';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(label: Text('Email')),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email address';
                            } else if (!value.contains('@')) {
                              return 'Please enter valid email address';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: schoolController,
                          decoration: InputDecoration(
                              label: Text('School / Institution')),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your school/instituition';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: addressController,
                          decoration: InputDecoration(label: Text('Address')),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                        ),
                        ElevatedButton(
                            onPressed: () {
                              submitForm();
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                minimumSize: Size(double.infinity, 60)),
                            child: Text('Submit'))
                      ],
                    ),
                  ),
                )),
          ],
        )),
      );
      // bottomNavigationBar: Container(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       _launchUrl(
      //           'https://www.dsd.gov.my/index.php/skillsmalaysia-menu/peringkat-malaysia/worldskills-malaysia-belia-wsmb');
      //     },
      //     child: Text('Visit the Webiste'),
      //     style: ElevatedButton.styleFrom(
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(8),
      //         ),
      //         minimumSize: Size(double.infinity, 60)),
      //   ),
      // )
    
  }
}
