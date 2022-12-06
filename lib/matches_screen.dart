import 'package:flutter/material.dart';
import 'package:responsi/base_network.dart';
import 'detail_screen.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen();

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  // final BaseNetwork matchesClient = BaseNetwork();
  late Future<List<dynamic>> matches;

  @override
  void initState() {
    matches = BaseNetwork.getList('matches');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: matches,
      builder: (context, snapshot) {
        var data = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return ListView.separated(
              separatorBuilder: ((context, index) {
                return const Divider(
                  color: Color.fromARGB(255, 255, 255, 255),
                  height: 8,
                );
              }),
              itemCount: 48,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(match: data![index].int),
                      ),
                    );
                  },
                  child: Container(
                    color: const Color.fromARGB(255, 237, 237, 237),
                    height: 130,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Image.network(
                                "https://countryflagsapi.com/png/${data![index]['homeTeam']['name']}",
                                width: 100,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                '${data[index]['homeTeam']['name']}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            "${data[index]['homeTeam']['goals']}",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const Text(
                            ":",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            "${data[index]['awayTeam']['goals']}",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Column(
                            children: [
                              Image.network(
                                "https://countryflagsapi.com/png/${data[index]['awayTeam']['name']}",
                                width: 100,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                '${data[index]['awayTeam']['name']}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
          } else {
            return const Text('Error');
          }
        } else {
          return const Text('Empty data');
        }
      },
    );
  }
}
