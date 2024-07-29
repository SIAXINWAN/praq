import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:praq_try/pages/homePage.dart';
import 'package:url_launcher/url_launcher.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: Image.asset(
            'lib/assets/0.jpeg',
            height: 100,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
        body: HomeTabPage(),
        bottomNavigationBar: Container(
          child: ElevatedButton(
            onPressed: () {
              _launchUrl(
                  'https://www.dsd.gov.my/index.php/skillsmalaysia-menu/peringkat-malaysia/worldskills-malaysia-belia-wsmb');
            },
            child: Text('Visit the Webiste'),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 60)),
          ),
        ));
  }
}
