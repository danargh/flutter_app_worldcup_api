import 'dart:async';

import 'package:flutter/material.dart';
import 'base_network.dart';

class DetailScreen extends StatefulWidget {
  final Map? match;
  const DetailScreen({this.match});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Map<String, dynamic>> matchDetail;
  Map<String, dynamic>? data;
  @override
  void initState() {
    matchDetail = BaseNetwork.get('matches/${widget.match!['id']}');
    super.initState();
  }

  int homePassAccuracy() {
    var homePasses = data!['homeTeam']['statistics']['passes'];
    var homePassesCompleted = data!['homeTeam']['statistics']['passesCompleted'];
    var homePassAccuracy = homePassesCompleted / homePasses * 100;
    homePassAccuracy = homePassAccuracy.round();
    return homePassAccuracy;
  }

  int awayPassAccuracy() {
    var awayPasses = data!['awayTeam']['statistics']['passes'];
    var awayPassesCompleted = data!['awayTeam']['statistics']['passesCompleted'];
    var awayPassAccuracy = awayPassesCompleted / awayPasses * 100;
    awayPassAccuracy = awayPassAccuracy.round();
    return awayPassAccuracy;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Match Id : ${widget.match!['id']}"),
        ),
        body: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 237, 237, 237),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Image.network(
                          "https://countryflagsapi.com/png/${widget.match!['homeTeam']['name']}",
                          width: 100,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '${widget.match!['homeTeam']['name']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      "${widget.match!['homeTeam']['goals']}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const Text(
                      ":",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      "${widget.match!['awayTeam']['goals']}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Column(
                      children: [
                        Image.network(
                          "https://countryflagsapi.com/png/${widget.match!['awayTeam']['name']}",
                          width: 100,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '${widget.match!['awayTeam']['name']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              color: const Color.fromARGB(255, 237, 237, 237),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder<Map<String, dynamic>>(
                  future: matchDetail,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      data = snapshot.data;
                      int homePassAccuracyInt = homePassAccuracy();
                      int awayPassAccuracyInt = awayPassAccuracy();
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Table(
                              children: [
                                const TableRow(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Center(child: Text('Stadion')),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Center(child: Text('Location')),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Text(
                                          '${data!['venue']}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Text(
                                          '${data!['location']}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 16, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Divider(
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Statistics',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Table(
                              children: [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 24, bottom: 4, top: 4),
                                      child: Text(
                                        '${data!['homeTeam']['statistics']['ballPossession']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Text(
                                          'Ball possession',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 24, bottom: 4, top: 4),
                                      child: Text(
                                        '${data!['awayTeam']['statistics']['ballPossession']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 24, bottom: 4, top: 4),
                                      child: Text(
                                        '${data!['homeTeam']['statistics']['attemptsOnGoal']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Text(
                                          'Shot',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 24, bottom: 4, top: 4),
                                      child: Text(
                                        '${data!['awayTeam']['statistics']['attemptsOnGoal']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 24, bottom: 4, top: 4),
                                      child: Text(
                                        '${data!['homeTeam']['statistics']['kicksOnTarget']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Text(
                                          'Shot on Goal',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 24, bottom: 4, top: 4),
                                      child: Text(
                                        '${data!['awayTeam']['statistics']['kicksOnTarget']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 24, bottom: 4, top: 4),
                                      child: Text(
                                        '${data!['homeTeam']['statistics']['corners']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Text(
                                          'Corners',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 24, bottom: 4, top: 4),
                                      child: Text(
                                        '${data!['awayTeam']['statistics']['corners']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 24, bottom: 4, top: 4),
                                      child: Text(
                                        '${data!['homeTeam']['statistics']['offsides']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Text(
                                          'Offside',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 24, bottom: 4, top: 4),
                                      child: Text(
                                        '${data!['awayTeam']['statistics']['offsides']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 24, bottom: 4, top: 4),
                                      child: Text(
                                        '${data!['homeTeam']['statistics']['foulsReceived']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Text(
                                          'Fouls',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 24, bottom: 4, top: 4),
                                      child: Text(
                                        '${data!['awayTeam']['statistics']['foulsReceived']}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 24, bottom: 4, top: 4),
                                      child: Text(
                                        '$homePassAccuracyInt%',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Text(
                                          'Pass accuracy',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 24, bottom: 4, top: 4),
                                      child: Text(
                                        '$awayPassAccuracyInt%',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Divider(
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Referees',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              color: const Color.fromARGB(255, 237, 237, 237),
                              height: 160,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 100.0,
                                      child: ListView.builder(
                                        shrinkWrap: false,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: data!['officials'].length,
                                        itemBuilder: (BuildContext context, int index) => SizedBox(
                                          width: 140,
                                          child: Card(
                                            color: Colors.white,
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Image.network(
                                                    'https://upload.wikimedia.org/wikipedia/id/thumb/e/e3/2022_FIFA_World_Cup.svg/1200px-2022_FIFA_World_Cup.svg.png',
                                                    width: 70,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        '${data!['officials'][index]['name']}',
                                                        textAlign: TextAlign.center,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      Text(
                                                        '${data!['officials'][index]['role']}',
                                                        textAlign: TextAlign.center,
                                                        style: const TextStyle(fontSize: 10),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Text('Error');
                      }
                    } else {
                      return const Text('Empty data');
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
