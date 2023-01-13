import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  GamePage({Key? key, this.gameTitle}) : super(key: key);

  final gameTitle;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  late String _gameTitle;
  var gameData = <String, dynamic>{
    "dummy" : "data",
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _gameTitle = widget.gameTitle;
    gameData = <String, dynamic>{
      "dummy" : "data",
    };
    getGameData();
  }

  void getGameData() {
    gameData = <String, dynamic>{
      "dummy" : "data",
    };
    FirebaseFirestore.instance.collection('Games').doc(_gameTitle).get()
        .then((querySnap) {
      print("Successfully got Game data in GamePage");
      print(querySnap.data());
      gameData = querySnap.data()!;
      setState(() {

      });
    }).catchError((error) {
      print("Failed to get Game data in GamePage");
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FOMO Tracker - " + _gameTitle.toString()),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 30,
              child: Image(
                image: NetworkImage(gameData["logo"]),
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 50,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      width: 350,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        child: Text(
                          'Description of ' + _gameTitle,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: BorderSide(color: Colors.blue),
                                )
                            )
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      width: 350,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        child: Text(
                          'Extra Details of ' + _gameTitle,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: BorderSide(color: Colors.blue),
                                )
                            )
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      width: 350,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        child: Text(
                          'Weekly Quests of ' + _gameTitle,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: BorderSide(color: Colors.blue),
                                )
                            )
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      width: 350,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        child: Text(
                          'Daily Quests of ' + _gameTitle,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: BorderSide(color: Colors.blue),
                                )
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 20,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      width: 150,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        child: Text(
                          'Add ' + _gameTitle + ' to my Library',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.blue),
                                )
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
