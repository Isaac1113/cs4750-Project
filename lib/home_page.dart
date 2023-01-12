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

  Future<Map<String, dynamic>> getUserProfile() async {
    var userProfile;

    await FirebaseFirestore.instance.collection('Users').doc(userID.toString()).get().then((value) {
      print("Successfully got the user data");
      print(value.data());
      userProfile = value.data();
      print(userProfile["username"]);
      FirebaseFirestore.instance.collection('Games').where(FieldPath.documentId, whereIn: userProfile["library"]).get()
          .then((querySS) {
        print("Successfully got all Games from database");
        querySS.docs.forEach((element) {
          print(element.id);
          print(element.data());
        });
      }).catchError((error) {
        print("Failed to get all Games from database");
        print(error);
      });
    }).catchError((error) {
      print("Failed to get the user data");
      print(error);
    });

    return userProfile;
  }

  var userID;
  var userProfile;
  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userID = FirebaseAuth.instance.currentUser?.uid;
    print(userID);
    FirebaseFirestore.instance.collection('Users').doc(userID.toString()).get().then((value) {
        print("Successfully got the user data");
        print(value.data());
        userProfile = value.data();
        print(userProfile["username"]);
        FirebaseFirestore.instance.collection('Games').where(FieldPath.documentId, whereIn: userProfile["library"]).get()
            .then((querySS) {
          print("Successfully got all Games from database");
          querySS.docs.forEach((element) {
            print(element.id);
            print(element.data());
          });
        }).catchError((error) {
          print("Failed to get all Games from database");
          print(error);
        });
      }).catchError((error) {
        print("Failed to get the user data");
        print(error);
      });
    // print(userProfile["username"]);
  }

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
              Text(
                (userProfile == null) ? 'My Game Library' : '${userProfile["username"]}\'s Game Library',
                style: optionStyle,
              ),
              Text(
                'Index 0: Home',
                style: optionStyle,
              ),
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
