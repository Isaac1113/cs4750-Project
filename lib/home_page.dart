import 'package:flutter/material.dart';
import 'tab_item.dart';
import 'signup_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  _HomePageState() { }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget selectTab(int index) {
    if (index == 0) {
      return Text(
        'Index 0: Home',
        style: optionStyle,
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
          //child: _widgetOptions.elementAt(_selectedIndex),
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
      )
    );
  }
}
