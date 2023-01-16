import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'game_page.dart';

class DatabaseGamesPage extends StatefulWidget {
  const DatabaseGamesPage({Key? key}) : super(key: key);

  @override
  State<DatabaseGamesPage> createState() => _DatabaseGamesPageState();
}

class _DatabaseGamesPageState extends State<DatabaseGamesPage> {

  Future<dynamic> getDatabaseGames() async {
    var allGames;

    await FirebaseFirestore.instance.collection('Games').get()
        .then((querySS) {
      print("Successfully got entire Games list in dbGamesPage");
      allGames = querySS;
      print(allGames);
      querySS.docs.forEach((element) {
        print(element.id);
        print(element.data());
      });
    }).catchError((error) {
      print("Failed to get entire Games list in dbGamesPage");
      print(error);
    });

    return allGames;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FOMO Tracker - Games"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Text(
                "Database Games",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )
            ),
            Expanded(
              flex: 90,
              child: FutureBuilder(
                future: getDatabaseGames(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var myList = snapshot.data?.docs;
                    snapshot.data?.docs.forEach((element) {
                      print(element.id);
                      print(element.data());
                    });

                    return ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: myList?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  String gameName = myList[index].id;
                                  String logo = myList[index]["logo"];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => GamePage(gameTitle: gameName, gameLogo: logo,))
                                  );
                                },
                                title: Container(
                                  height: 40,
                                  margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 20),
                                          child: Image(
                                            image: NetworkImage('${myList[index]["logo"]}'),
                                          ),
                                        ),
                                        Text('${myList[index].id}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 2,
                              ),
                            ],
                          );
                        }
                    );
                  } else if (snapshot.hasError) {
                    print("Error has occurred here:");
                    print(snapshot);
                    return Text("Error");
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text("Loading..."),
                        ],
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
