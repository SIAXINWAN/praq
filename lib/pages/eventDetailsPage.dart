import 'package:flutter/material.dart';
import 'package:praq_try/model/event.dart';
import 'package:praq_try/model/register.dart';
import 'package:praq_try/pages/registerForm.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({
    super.key,
    required this.event,
  });
  final Event event;

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(children: [
            Center(
                child: Text(
              'EVENT DETAILS',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Image.asset(
                'lib/assets/${widget.event.imageUrl}',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(widget.event.title),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              child: Text(widget.event.desc),
            ),

            // SizedBox(
            //   height: 10,
            // )

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Register'),
                              content: Text('Do you want to register?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('No')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterFormPage(
                                                      event: widget.event)));
                                    },
                                    child: Text('Yes'))
                              ],
                            ));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(double.infinity, 40)),
                  child: Text('Register')),
            )
          ])),
    );
  }
}
