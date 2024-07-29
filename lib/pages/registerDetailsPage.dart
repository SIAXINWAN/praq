import 'package:flutter/material.dart';
import 'package:praq_try/model/event.dart';
import 'package:praq_try/model/register.dart';
import 'package:praq_try/widgets/RegisterDetailsCard.dart';

class RegisterDetailsTabPage extends StatelessWidget {
  const RegisterDetailsTabPage({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
              builder: (context) =>  RegisterDetailsPage(event: event));
        },
      ),
    );
  }
}

class RegisterDetailsPage extends StatefulWidget {
  const RegisterDetailsPage({super.key, required this.event, });
  final Event event;
  // final Register register;

  @override
  State<RegisterDetailsPage> createState() => _RegisterDetailsPageState();
}

class _RegisterDetailsPageState extends State<RegisterDetailsPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
    );
  }
}
