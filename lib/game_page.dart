import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fomo_app/quest_page.dart';

class GamePage extends StatefulWidget {
  GamePage({Key? key, this.gameTitle, this.gameLogo}) : super(key: key);

  final gameTitle;
  final gameLogo;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  late String _gameTitle;
  late String _gameLogo;
  var gameData = <String, dynamic>{
    "dummy" : "data",
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _gameTitle = widget.gameTitle;
    _gameLogo = widget.gameLogo;
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
                image: NetworkImage(_gameLogo),
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
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Description:'),
                                  content: Text(gameData["description"]),
                                  actions: [
                                    TextButton(
                                      child: Text('Close'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.blue
                                      ),
                                    )
                                  ],
                                );
                              });
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
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Details:'),
                                  content: Text(gameData["details"]),
                                  actions: [
                                    TextButton(
                                      child: Text('Close'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.blue
                                      ),
                                    )
                                  ],
                                );
                              });
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
                          FirebaseFirestore.instance.collection('Games').doc(_gameTitle).collection('Weekly').get()
                              .then((querySS) {
                                print("Successfully got the quest data in GamePage");
                                print(querySS.docs.runtimeType);
                                querySS.docs.forEach((element) {
                                  print(element.id);
                                  print(element.data());
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => QuestPage(gameTitle: _gameTitle, gameLogo: _gameLogo, questType: "Weekly", questData: querySS.docs,))
                                );
                          }).catchError((error) {
                            print("Failed to get the quest data in GamePage");
                            print(error);
                          });
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
                          FirebaseFirestore.instance.collection('Games').doc(_gameTitle).collection('Daily').get()
                              .then((querySS) {
                            print("Successfully got the quest data in GamePage");
                            print(querySS.docs.runtimeType);
                            querySS.docs.forEach((element) {
                              print(element.id);
                              print(element.data());
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => QuestPage(gameTitle: _gameTitle, gameLogo: _gameLogo, questType: "Daily", questData: querySS.docs,))
                            );
                          }).catchError((error) {
                            print("Failed to get the quest data in GamePage");
                            print(error);
                          });
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
                        onPressed: () async {
                          var userProfile;
                          var userGames;
                          var userLibrary;
                          var libGame = null;
                          var userID = FirebaseAuth.instance.currentUser?.uid;
                          bool gameInLibrary = true;
                          await FirebaseFirestore.instance.collection('Users').doc(userID.toString()).get().then((value) {
                            print("Successfully got user profile in gamePage");
                            print(value.data());
                            print(value.data()!["library"]);
                            userLibrary = value.data()!["library"];
                            print(value.data()!["library"].runtimeType);
                            try {
                              libGame = value.data()!["library"].firstWhere((element) => element == _gameTitle);
                              gameInLibrary = true;
                            } catch(e) {
                              print("In catch block");
                              print(e);
                              gameInLibrary = false;
                            }
                            userProfile = value.data();
                          }).catchError((error) {
                            print("Failed to get user profile in gamePage");
                            print(error);
                          });
                          if (gameInLibrary) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text(_gameTitle + " is already in your library."),
                                    actions: [
                                      TextButton(
                                        child: Text('Close'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: TextButton.styleFrom(
                                            foregroundColor: Colors.blue
                                        ),
                                      )
                                    ],
                                  );
                                });
                          } else {
                            userLibrary.add(_gameTitle);
                            print(userLibrary);
                          }
                        },
                        child: Text(
                          'Add ' + _gameTitle + ' to my Library',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),

                                  side: BorderSide(color: Colors.green),
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
