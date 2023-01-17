import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fomo_app/db_game_page.dart';
import 'package:fomo_app/game_page.dart';
import 'signup_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var userID;
  var userProfile;
  var allGames;
  int _selectedIndex = 0;

  Future<Map<String, dynamic>> getUserProfile() async {
    userID = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance.collection('Users').doc(userID.toString()).get().then((value) {
      print("Successfully got the user data");
      print(value.data());
      userProfile = value.data();
      print(userProfile["username"]);
    }).catchError((error) {
      print("Failed to get the user data");
      print(error);
    });

    return userProfile;
  }

  Future<dynamic> getGames() async {
    userID = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance.collection('Users').doc(userID.toString()).get().then((value) {
      print("Successfully in getGames()");
      print(value.data());
      userProfile = value.data();
    }).catchError((error) {
      print("Failed in getGames()");
      print(error);
    });
    await FirebaseFirestore.instance.collection('Games').where(FieldPath.documentId, whereIn: userProfile["library"]).get()
        .then((querySS) {
      print("Successfully got all Games from database");
      allGames = querySS;
      print(allGames);
      querySS.docs.forEach((element) {
        print(element.id);
        print(element.data());
      });
    }).catchError((error) {
      print("Failed to get all Games from database");
      print(error);
    });

    return allGames;
  }

  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget refresh(var myList) {
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
  }

  Widget selectTab(int index) {
    if (index == 0) {
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: FutureBuilder(
                  future: getUserProfile(),
                  builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${snapshot.data!["username"]}\'s Game Library',
                            style: optionStyle,
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.data);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'My Game Library',
                              style: optionStyle,
                            ),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Loading User... Game Library',
                            style: optionStyle,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
              Expanded(
                flex: 90,
                child: FutureBuilder(
                  future: getGames(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var myList = snapshot.data?.docs;
                      snapshot.data?.docs.forEach((element) {
                        print(element.id);
                        print(element.data());
                      });
                      return refresh(myList);
                    } else if (snapshot.hasError) {
                      print("Error has occurred here:");
                      print(snapshot);
                      return Text("Library is empty");
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DatabaseGamesPage())
            );
          },
          tooltip: 'Add Game',
          child: const Icon(Icons.add),
        ),
      );
    }
    else {
      return Column(
        children: [
          Expanded(
            flex: 10,
            child: FutureBuilder(
              future: getUserProfile(),
              builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${snapshot.data!["username"]}\'s Game Library',
                        style: optionStyle,
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.data);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'My Game Library',
                        style: optionStyle,
                      ),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Loading User... Game Library',
                        style: optionStyle,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          Expanded(
            flex: 70,
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
                                title: Text('Warning!'),
                                content: Text("Are you sure you want to delete your entire library?"),
                                actions: [
                                  TextButton(
                                    child: Text('Yes'),
                                    onPressed: () {
                                      FirebaseFirestore.instance.collection("Users").doc(userID).set({
                                        "library": [],
                                        "username": userProfile["username"],
                                      }).then((value) {
                                        print("Successfully deleted user's entire library");
                                      }).catchError((error) {
                                        print("Failed to delete the user's entire library");
                                        print(error);
                                      });
                                      Navigator.pop(context);
                                    },
                                    style: TextButton.styleFrom(
                                        foregroundColor: Colors.blue
                                    ),
                                  ),
                                  TextButton(
                                    child: Text('No'),
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
                        'Delete my library',
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
                    width: 350,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                side: BorderSide(color: Colors.red),
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
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FOMO Tracker - Home"),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                setState(() {

                });
              },
              child: Icon(
                Icons.refresh,
                size: 26,
              ),
            ),
          )
        ],
      ),
      body: Center(
          child: selectTab(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
