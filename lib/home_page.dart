import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'tab_item.dart';
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
      // FirebaseFirestore.instance.collection('Games').where(FieldPath.documentId, whereIn: userProfile["library"]).get()
      //     .then((querySS) {
      //   print("Successfully got all Games from database");
      //   allGames = querySS.docs;
      //   querySS.docs.forEach((element) {
      //     print(element.id);
      //     print(element.data());
      //   });
      // }).catchError((error) {
      //   print("Failed to get all Games from database");
      //   print(error);
      // });
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

                      return ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: myList?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 50,
                              color: Colors.amber[400],
                              child: Center(child: Text('${myList![index].id}')),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          tooltip: 'Add Game',
          child: const Icon(Icons.add),
        ),
      );
    }
    else if (index == 1) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            width: 150,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupPage())
                );
              },
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        side: BorderSide(color: Colors.blue),
                      )
                  )
              ),
            ),
          ),
          Text(
            'Index 1: Notifications',
            style: optionStyle,
          ),
        ],
      );
    }
    else {
      return Text(
        'Index 2: Profile',
        style: optionStyle,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FOMO Tracker - Home"),
        centerTitle: true,
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
            icon: Icon(Icons.notifications),
            label: 'Notifications',
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
