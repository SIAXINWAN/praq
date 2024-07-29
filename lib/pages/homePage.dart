import 'package:flutter/material.dart';
import 'package:praq_try/model/event.dart';
import 'package:praq_try/pages/eventDetailsPage.dart';
import 'package:praq_try/widgets/eventCard.dart';

class HomeTabPage extends StatelessWidget {
  const HomeTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Event> list = [
    Event(
        title: 'Autonomous Mobile Robotics',
        desc:
            'Designing, building, and maintaining robots to solve problems in industries',
        imageUrl: '1.jpeg'),
    Event(
        title: 'Cloud Computing',
        desc: 'Cloud Computing has become a key paret of corporate',
        imageUrl: '2.jpeg'),
    Event(
        title: 'Cyber Security',
        desc:
            "Information security analysts work to protect an organizations's computer",
        imageUrl: '3.jpeg'),
    Event(
        title: '3D Digital Game Art',
        desc: 'A 3D Digital Game Artist uses their',
        imageUrl: '4.jpeg')
  ];
  String keyword = '';
  final SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var filterList = list
        .where((e) =>
            e.title.toLowerCase().contains(keyword.toLowerCase()) ||
            e.desc.toLowerCase().contains(keyword.toLowerCase()))
        .toList();

    return Stack(children: [
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: SearchController,
              decoration: InputDecoration(
                label: Center(child: Text('Search')),
              ),
              onChanged: (value) {
                setState(() {
                  keyword = value.trim();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: filterList.length,
                itemBuilder: (context, index) {
                  return EventCard(event: filterList[index],);
                }),
          ),
        ],
      ),
    ]);
  }
}
