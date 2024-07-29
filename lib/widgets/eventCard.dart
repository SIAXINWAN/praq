import 'package:flutter/material.dart';
import 'package:praq_try/model/event.dart';
import 'package:praq_try/model/register.dart';
import 'package:praq_try/pages/eventDetailsPage.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event, });
  final Event event;
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventDetailsPage(
                          event: event, 
                        )));
          },
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 150,
                  child: Image.asset(
                    'lib/assets/${event.imageUrl}',
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        event.title,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      child: Text(event.desc),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
