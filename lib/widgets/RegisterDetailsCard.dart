import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:praq_try/model/event.dart';
import 'package:praq_try/model/register.dart';

class EventDetailsCard extends StatefulWidget {
  const EventDetailsCard({super.key, required this.event, required this.register});
  final Event event;
  final Register register;

  @override
  State<EventDetailsCard> createState() => _EventDetailsCardState();
}

class _EventDetailsCardState extends State<EventDetailsCard> {
  
  @override
  Widget build(BuildContext context) {
    
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Text('Name : ${widget.register.name}'),
            Text('Category: ${widget.event.title}'),
            Text('IC Number : ${widget.register.icno}'),
            Text('Email : ${widget.register.email}'),
            Text('School/Insitution : ${widget.register.school}')
          ],
        ),
      )
    );
    
  }
}